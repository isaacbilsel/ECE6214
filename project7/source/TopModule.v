`timescale 1ns / 1ps
module TopModule(
    input clk,
    input rst_n,
    input [3:0] data_in,     // 4-bit input data from the symbol generator.
    input data_valid,        // Signal indicating when data_in contains valid data.
    input coeff_write_enable,
    input [6:0] coeff_addr,
    input [7:0] coeff_data,

    output reg [11:0] data_out,  // 12-bit output data after FIR filtering.
    output reg data_out_valid    // Signal indicating when data_out contains valid data.
);
	
	// Register necessary inputs
	// reg data_valid_q; 
	
    // Upsampler internal signals
    wire [3:0] upsampled_data = 4'b0000;
    reg upsampled_data_valid = 0;
    reg [11:0] filter_out;
    wire [11:0] filter_out_wire;
    reg [3:0] input_data_buffer = 4'b0000;
    reg [6:0] counter = 6'b000000; // To count up to 13 (input + 12 zeros)

	parameter LATENCY = 71;

    /*
	// Filter internal signals
	wire coeff_write_enable;
	wire [6:0] coeff_addr;
	wire [7:0] coeff_data;
	wire [3:0] upsampled_data_wire;
    */
    always @(posedge clk) begin
   		filter_out = filter_out_wire;
	end 
	
	// Upsampler Instatiation
	upsampler u_upsampler(
		.clk(clk),
		.rst_n(rst_n),
		.new_symbol(data_valid),
		.input_data(input_data),
		.output_data(upsampled_data)
	);
	
	// assign upsampled_data_wire = upsampled_data;

    // FIR Filter instantiation
    fir_filter u_fir_filter(
        .clk(clk),
		.sample_in(upsampled_data),
        .coeff_write(data_valid), 	//coeff_write_enable?
        .coeff_in(coeff_data),
        .coeff_addr(coeff_addr),
        .fir_out(filter_out_wire)
    );

	
	always @(posedge clk or posedge rst_n) begin
		if (!rst_n) begin
			counter <= 0;
			data_out <= 0;
			// data_valid_q <= 0;
		end
		else if (counter < LATENCY) begin
			counter <= counter + 1;
			data_out <= 0;
			data_out_valid <= 0;
		end
		else begin
			data_out <= filter_out;
			data_out_valid <= 1;
		end

	end
    
/*

    // Upsampler logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            upsampled_data <= 0;
            upsampled_data_valid <= 0;
            input_data_buffer <= 0;
        end else if (data_valid && counter == 0) begin // Load new data when counter is 0 and data is valid
            input_data_buffer <= data_in;
            upsampled_data <= data_in;
            upsampled_data_valid <= 1;
            counter <= counter + 1;
        end else if (counter > 0 && counter < 13) begin // Output zeros for padding
            upsampled_data <= 0;
            upsampled_data_valid <= 1; // Still valid, but it's a padded zero
            counter <= counter + 1;
            if (counter == 12) counter <= 0; // Reset counter after 13th cycle
        end else begin
            upsampled_data_valid <= 0; // Invalid in case of any sync issues
        end
    end

    // Connecting the validity of upsampled data to the output validity.
    // This is a simple connection. Depending on the processing delay of the FIR filter, 
    // you might need to adjust when `data_out_valid` is asserted.
    always @(posedge clk) begin
        data_out_valid <= upsampled_data_valid;
    end
*/
	

endmodule
