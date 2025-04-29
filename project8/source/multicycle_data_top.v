`timescale 1ns/1ps

module multicycle_data_top #(
 parameter DATA_WIDTH = 19
) (
    input wire aclk,
    input wire bclk,
    input wire rst_n,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire load_data,
    output wire [DATA_WIDTH-1:0] data_out
);

    wire [DATA_WIDTH-1:0] data_hold;
    wire load_toggle;

    multicycle_data_src #(.DATA_WIDTH(DATA_WIDTH)) u_src (
        .aclk (aclk),
        .rst_n (rst_n),
        .data_in (data_in),
        .load_data (load_data),
        .data_hold (data_hold),
        .load_toggle (load_toggle)
    );

    multicycle_data_dst #(.DATA_WIDTH(DATA_WIDTH)) u_dst (
        .bclk (bclk),
        .rst_n (rst_n),
        .data_hold (data_hold),
        .load_toggle_src (load_toggle),
        .data_out (data_out)
    );

endmodule