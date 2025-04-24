`timescale 1ns / 1ps
module baseband_dsp(
    input wire data_in,
    input wire data_clk,
    input wire dsp_clk,
    input wire rst_n,
    input wire msg_in,
    input wire rw,
    input wire [9:0] coeff_addr,
    input wire [7:0] coeff_in,
    output wire coeff_read_out,
    output wire [9:0] I_out,
	output wire [9:0] Q_out
);

    // baseband interface

    dsp_top dsp (
        .clk(dsp_clk),
        .rst_n(rst_n),
        .msg_in(~CSN),		        // This might be wrong
        .sample_rate(sample_rate),
        .data_in_i(I),
        .data_in_q(Q),
        .new_symbol(I || Q),        // This may also need to be set in tb
        .coeff_rw(coeff_rw),		// CDC output
        .coeff_addr(coeff_addr),	// CDC output/output
        .coeff_in(coeff_in),		// CDC output
        .I_out(I_out),
        .Q_out(Q_out),
        .coeff_read_out(coeff_read_out) // CDC input
    );

endmodule