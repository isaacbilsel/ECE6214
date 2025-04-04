`timescale 1ns / 1ps
module TopModule(
    input clk,
    input rst_n,				
    /*
    We need to synchronize reset. Reset module should take in asynchronous reset input and clock 
    and output a syncrhonized reset. The output of the asyncrhonous reset should be fed everywhere 
    that I use rst_n here. 
    */
    input wire [3:0] sample_rate,
    input [3:0] data_in,     	// 4-bit input data from the symbol generator.
    input coeff_write,
    input [7:0] coeff_in, 		// We may need to make this a two dimensional array
    input [6:0] coeff_addr,
    input wire new_symbol, 		
    output wire [11:0] data_out,  // 12-bit output data after FIR filtering.
    output reg data_out_valid    // Signal indicating when data_out contains valid data.
);
	
    // Internal signals
    wire [3:0] upsampler_out;
	wire [11:0] filter_out;
 
    // Time taken for filter to propagate output through and flush completely
	// Each filter has 4 CC latency, filters are pipelined, so
	// latency = 2 * (num_taps-1) + 4 = 144
    parameter LATENCY = 144;
    
    // Datapath reset variables
    reg [7:0] counter;
    reg [7:0] counter_next;
    reg data_out_valid_next;
	
	// Upsampler Instatiantion
	upsampler u_upsampler(
		.clk(clk),
		.rst_n(rst_n),
		.sample_rate(sample_rate),
		.new_symbol(new_symbol),
		.input_data(data_in),
		.output_data(upsampler_out)
	);

    // FIR Filter instantiation
    fir_filter u_fir_filter(
        .clk(clk),
		.sample_in(upsampler_out),
        .coeff_write(coeff_write),
        .coeff_in(coeff_in),
        .coeff_addr(coeff_addr),
        .fir_out(filter_out)
    );
	
	// Logic for Datapath reset
	always @(posedge clk or posedge rst_n) begin
		if (!rst_n) begin
			counter <= 0;
			data_out_valid <= 0;
		end
		else begin
			counter <= counter_next;
			data_out_valid <= data_out_valid_next;
		end
	end
	
	always @(*) begin
		data_out_valid_next = data_out_valid;
		counter_next = counter;
		if(data_in) begin
			counter_next = counter + 1'b1;
		end
		if (counter < LATENCY) begin
			data_out_valid_next = 0;
		end
		else begin
			data_out_valid_next = 1'b1;
		end
	end
    
    assign data_out = filter_out;

endmodule
