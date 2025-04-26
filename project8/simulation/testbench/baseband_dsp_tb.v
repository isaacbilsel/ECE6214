`timescale 1ns / 1ps
`include "modulator_signals.vh"

module baseband_dsp_tb;

    reg data_in;
    reg data_clk;
    reg dsp_clk;
    reg rst_n;
    reg msg_in;
    reg rw;
    reg [9:0] coeff_addr;
    reg [7:0] coeff_in;
    wire coeff_read_out;
    wire [9:0] I_out;
    wire [9:0] Q_out; 

    baseband_dsp DUT(
        .data_in(data_in),
        .data_clk(data_clk),
        .dsp_clk(dsp_clk),
        .rst_n(rst_n),
        .msg_in(msg_in),
        .rw(rw),
        .coeff_addr(coeff_addr),
        .coeff_in(coeff_in),
        .coeff_read_out(coeff_read_out),
        .I_out(I_out),
	    .Q_out(Q_out)
    );

    always #8.333 data_clk = ~data_clk;
    always #3.846 dsp_clk = ~dsp_clk;


    initial begin


    end

endmodule

