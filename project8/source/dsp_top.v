`timescale 1ns / 1ps
module dsp_top(
    input clk,
    input rst_n,				
    input wire [3:0] sample_rate,
    input [3:0] data_in_i,     	// 4-bit input data from the symbol generator.
    input [3:0] data_in_q,
    input coeff_rw,
    input msg_in,
    input [7:0] coeff_in, 		// We may need to make this a two dimensional array
    input [9:0] coeff_addr,
    input wire new_symbol, 		
    output wire [9:0] I_out,  // Inphase 10 bit output to DAC
    output wire [9:0] Q_out,  // Quadrature 10 bit output to DAC
    output reg [7:0] coeff_read_out
);

    // Internal signals
    wire [3:0] upsampler_out_i;
    wire [3:0] upsampler_out_q;
	wire [11:0] filter_out_i;
	wire [11:0] filter_out_q;
    wire rst_n_sync_wire;

    // SPI communication internal signals
    wire coeff_write;
    wire coeff_read;
    wire [9:0] coeff_i_addr;
    wire [9:0] coeff_q_addr;
    wire [7:0] coeff_read_out_i;
    wire [7:0] coeff_read_out_q;
    reg [7:0] coeff_read_out_next;

    // Map global address to a local address in coefficient memory of Q or I filter
    assign coeff_i_addr = (coeff_addr > 10'd127 & coeff_addr < 10'd199) ? (coeff_addr-128) : 10'd0;
    assign coeff_q_addr = (coeff_addr > 10'd255 & coeff_addr < 10'd327) ? (coeff_addr-257) : 10'd0;

    assign coeff_read = msg_in ? ~coeff_rw : 0;
    assign coeff_write = msg_in ? coeff_rw: 0;

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
    parameter IDLE = 1'b0;
    parameter COMPUTE = 1'b1;
    reg state;
    reg state_next;
                            
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

    // FIR Filter instantiation for i
    fir_filter i_fir_filter(
        .clk(clk),
		.sample_in(upsampler_out_i),
        .coeff_read(coeff_read),
        .coeff_write(coeff_write),
        .coeff_in(coeff_in),
        .coeff_addr(coeff_i_addr),
        .fir_out(filter_out_i),
        .coeff_read_out(coeff_read_out_i)
    );

    fir_filter q_fir_filter(
        .clk(clk),
		.sample_in(upsampler_out_q),
        .coeff_read(coeff_read),
        .coeff_write(coeff_write),
        .coeff_in(coeff_in),
        .coeff_addr(coeff_q_addr),
        .fir_out(filter_out_q),
        .coeff_read_out(coeff_read_out_q)
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
            coeff_read_out <= coeff_read_out_next;
            state <= state_next;
        end
    end
	
	always @(*) begin
		data_out_valid_next <= data_out_valid;
		counter_next <= counter;
        coeff_read_out_next <= coeff_read_out;
        state_next <= state;
        case(state)
            IDLE: begin
                if(new_symbol) begin
                    counter_next <= counter + 1'b1;
                    state_next <=  COMPUTE;
                end
            end
            COMPUTE: begin
                if (counter < LATENCY) begin
                    data_out_valid_next <= 0;
                    state_next <= COMPUTE; 
                    counter_next <= counter + 1'b1;
                end
                else begin
                    data_out_valid_next <= 1'b1;
                    state_next <= IDLE; 
                    counter_next <= 8'd0;
                end
            end
        endcase

        // Set read output if address is valid and coeff_read flag is true
        if (coeff_addr > 10'd127 & coeff_addr < 10'd199 & coeff_read)
            coeff_read_out_next <= coeff_read_out_i;
        else if (coeff_addr > 10'd255 & coeff_addr < 10'd327 & coeff_read)
            coeff_read_out_next <= coeff_read_out_q;
        else 
            coeff_read_out_next <= 8'd0;
	end

    // Mulyiply outputs by valid flag to flush to zero if invalid
    // Truncate outputs to 10 bits (round-towards-zero rounding) 
    assign I_out = (filter_out_i[11:2] * data_out_valid);
    assign Q_out = (filter_out_q[11:2] * data_out_valid);

endmodule
