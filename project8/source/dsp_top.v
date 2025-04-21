`timescale 1ns / 1ps
module dsp_top(
    input clk,
    input rst_n,				
    input wire [3:0] sample_rate,
    input [3:0] data_in_i,     	// 4-bit input data from the symbol generator.
    input [3:0] data_in_q,
    input rw,
    input msg_in,
    input [7:0] coeff_in, 		// We may need to make this a two dimensional array
    input [9:0] mem_addr,
    input wire new_symbol, 		
    output wire [9:0] I_out,  // Inphase 10 bit output to DAC
    output wire [9:0] Q_out,  // Quadrature 10 bit output to DAC
    output reg [7:0] mem_read_out
);

    // Internal signals
    wire [3:0] upsampler_out_i;
    wire [3:0] upsampler_out_q;
	wire [11:0] filter_out_i;
	wire [11:0] filter_out_q;
    wire rst_n_sync_wire;

    // SPI communication internal signals
    wire write;
    wire read;
    wire [9:0] coeff_i_addr;
    wire [9:0] coeff_q_addr;
    wire [7:0] coeff_read_out_i;
    wire [7:0] coeff_read_out_q;
    wire [7:0] sample_read_out_i;
    wire [7:0] sample_read_out_q;

    reg [7:0] mem_read_out_next;

    // Map global address to a local address in coefficient memory of Q or I filter
    assign coeff_i_addr = (mem_addr > 10'd127 && mem_addr < 10'd199) ? (mem_addr-128) : 10'd0;
    assign coeff_q_addr = (mem_addr > 10'd255 && mem_addr < 10'd327) ? (mem_addr-256) : 10'd0;

    // Map global address to local address of output memory of Q or I filter
    assign sample_i_addr = (mem_addr > 10'd511 && mem_addr < 10'd640) ? (mem_addr-512) : 10'd0;
    assign sample_q_addr = (mem_addr > 10'd767 && mem_addr < 10'd896) ? (mem_addr-768) : 10'd0;

    assign read = msg_in ? ~rw : 0;
    assign write = msg_in ? rw: 0;

    // Time taken for filter to propagate output through and flush completely
	// Each filter has 4 CC latency, filters are pipelined, so
	// latency = 2 * (num_taps-1) + 4 = 144
    parameter LATENCY = 144;
    
    // Datapath reset variables
    reg [7:0] counter;
    reg [7:0] counter_next;
    reg data_out_valid;
    reg data_out_valid_next;

    // Simple FSM variables
    parameter IDLE = 2'b00;
    parameter COMPUTE = 2'b01;
    parameter OUTPUT = 2'b10;
    reg [1:0] state;
    reg [1:0] state_next;
                            
    // Reset Synchronization Instantiation
    reset_synchronization rst(.clk(clk),
                            .rst_n(rst_n),
                            .rst_n_sync(rst_n_sync_wire)
    );
                            
	// Upsampler Instatiantion
	upsampler u_upsampler(
		.clk(clk),
		.rst_n(rst_n_sync_wire),
		.sample_rate(sample_rate),
		.new_symbol(new_symbol),
		.input_data_1(data_in_i),
		.input_data_2(data_in_q),
		.output_data_1(upsampler_out_i),
		.output_data_2(upsampler_out_q)
	);

    // FIR Filter instantiation
    fir_filter i_fir_filter(
        .clk(clk),
		.sample_in(upsampler_out_i),
        .coeff_read(read),
        .coeff_write(coeff_write),
        .coeff_in(coeff_in),
        .coeff_addr(coeff_i_addr),
        .fir_out(filter_out_i),
        .coeff_read_out(coeff_read_out_i)
    );

    fir_filter q_fir_filter(
        .clk(clk),
		.sample_in(upsampler_out_q),
        .coeff_read(read),
        .coeff_write(coeff_write),
        .coeff_in(coeff_in),
        .coeff_addr(coeff_q_addr),
        .fir_out(filter_out_q),
        .coeff_read_out(coeff_read_out_q)
    );

    // Sample Storage Instatiation
    sample_storate i_sample_storage (
        .clk(clk),
        .rst_n(rst_n_sync_wire),
        .sample_in(filter_out_i),
        .sample_addr(sample_i_addr),
        .sample_read(read),    
        .counter_begin(data_out_valid), 
        .sample_read_out(sample_read_out_i)
    );

    sample_storage q_sample_storage (
        .clk(clk),
        .rst_n(rst_n_sync_wire),
        .sample_in(filter_out_q),
        .sample_addr(sample_q_addr),
        .sample_read(read),   
        .counter_begin(data_out_valid), 
        .sample_read_out(sample_read_out_q)
    );

	// Logic for Datapath reset
    always @(posedge clk or negedge rst_n_sync_wire) begin
        if (!rst_n_sync_wire) begin
            counter <= 0;
            data_out_valid <= 0;
            state <= IDLE;
        end 
        else begin
            counter <= counter_next;
            data_out_valid <= data_out_valid_next;
            mem_read_out <= mem_read_out_next;
            state <= state_next;
        end
    end
	
    // May need to use a shift reg here instead
	always @(*) begin
		data_out_valid_next <= data_out_valid;
		counter_next <= counter;
        mem_read_out_next <= mem_read_out;
        state_next <= state;
        case(state)
            IDLE: begin
                if(new_symbol) begin
                    counter_next <= counter + 1'b1;
                    state_next <=  COMPUTE;
                end
                else begin
                    counter_next <= 1'b0;
                    state_next <= IDLE;
                end
            end
            COMPUTE: begin
                if (new_symbol) begin
                    counter_next <= 1'b1; 
                    state_next <= COMPUTE;
                    data_out_valid_next <= 0;
                end
                else if (counter < LATENCY) begin
                    data_out_valid_next <= 0;
                    state_next <= COMPUTE; 
                    counter_next <= counter + 1'b1;
                end
                else begin
                    data_out_valid_next <= 1'b1;
                    state_next <= OUTPUT; 
                    counter_next <= 8'd0;
                end
            end
            OUTPUT: begin
                state_next <= IDLE; 
                data_out_valid_next <= 1'b0;
            end
            default: begin
                state_next <= IDLE;
                data_out_valid_next <= 1'b0;
            end
        endcase

        // Set read output if address is valid and read flag is true // Rewrite this with case statements
        if (mem_addr > 10'd127 & mem_addr < 10'd199 & read)
            mem_read_out_next <= coeff_read_out_i;
        else if (mem_addr > 10'd255 & mem_addr < 10'd327 & read)
            mem_read_out_next <= coeff_read_out_q;
        
        else if (mem_addr > 10'd511 & mem_addr < 10'd640 & read)
            mem_read_out_next <= sample_read_out_i;
        else if (mem_addr > 10'd767 & mem_addr < 10'd896 & read)
            mem_read_out_next <= sample_read_out_q;
        else 
            mem_read_out_next <= 8'd0;
	end

    // Mulyiply outputs by valid flag to flush to zero if invalid
    // Round-towards-zero rounding. This should probably be done more cleanly
    assign I_out = (filter_out_i < 0 && filter_out_i[1:0] != 2'b00) ? ((filter_out_i >> 2) * data_out_valid + 1) : ((filter_out_i >> 2) * data_out_valid);
    assign Q_out = (filter_out_q < 0 && filter_out_q[1:0] != 2'b00) ? ((filter_out_q >> 2) * data_out_valid + 1) : ((filter_out_q >> 2) * data_out_valid);

endmodule
