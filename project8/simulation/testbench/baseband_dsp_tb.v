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
    output wire coeff_read_out;
    output wire [9:0] I_out;
    wire [9:0] Q_out; 



endmodule

