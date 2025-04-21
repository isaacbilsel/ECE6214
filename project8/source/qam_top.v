`timescale 1ns / 1ps
module qam_top(
	input wire SCLK,
	input wire dsp_clk,
	input wire MOSI,
	input wire CSN,
	input wire rst_n,
	input wire [3:0] I,
	input wire [3:0] Q,

	output wire MISO,
	output wire MISO_enable,
	output wire [9:0] I_out,
	output wire [9:0] Q_out
	);

	//internal signals
	wire [7:0]			       reg_read_data;
	wire [9:0]			       reg_address;
	wire [7:0]			       reg_write_data;
	wire				       reg_write_enable;
	wire				       reg_read_enable;

	//interfacing
	SPI_Interface cmd_interface(
		.SCLK(SCLK),
		.MOSI(MOSI),
		.CSN(CSN),
		.rst_n(rst_n),
		.reg_read_data(reg_read_data),
		.MISO(MISO),
		.MISO_enable(MISO_enable),
		.reg_address(reg_address),
		.reg_write_data(reg_write_data),
		.reg_write_enable(reg_write_enable),
		.reg_read_enable(reg_read_enable)
	);

	// CDC module here
	

	dsp_top dsp (
		.clk(dsp_clk),
        .rst_n(rst_n),
		.msg_in(~CSN),		// This might be wrong
        .sample_rate(sample_rate),
        .data_in_i(I),
		.data_in_q(Q),
        .new_symbol(I || Q), // This may also need to be set in tb
        .coeff_rw(coeff_rw),		// CDC output
        .coeff_addr(coeff_addr),	// CDC output/output
        .coeff_in(coeff_in),		// CDC output
        .I_out(I_out),
		.Q_out(Q_out),
		.coeff_read_out(coeff_read_out) // CDC input
	);

endmodule // qam_top
