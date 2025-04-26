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
    input wire enable,
    input wire [3:0] sample_rate,
    output wire mapping,
    output wire coeff_read_out,
    output wire [9:0] I_out,
	output wire [9:0] Q_out
);

    // Internal signals
    wire [7:0] cdc_fifo_out;
    wire i_q_data_fifo_full;
    wire [3:0] i_data;
    wire [3:0] q_data;
    wire new_symbol;

    // baseband interface
    baseband_data u_baseband_data(
        .data_clk(data_clk),
        .rst_n(rst_n_data),
        .data_in(data_in),
        .enable(enable),
        .i_q_data_fifo_full(i_q_data_fifo_full),
        .i_data(i_data),
        .q_data(q_data),
        .new_symbol(new_symbol),
        .mapping(mapping)
	);
	
    //synchronize i and q data CDC FIFO between baseband data clock domain and symbol storage clock domain
    sync_fifo u_i_q_data(
        .clk_write(data_clk),
        .clk_read(dsp_clk), 
        .rst_n_write(rst_n_data),       //rename rst 
        .rst_n_read(rst_n_dsp),         //rename rst
        .write_data({i_data, q_data}),
        .write_enable(new_symbol),
        .read_enable(dsp_clk),          // Not sure how to assign this signal
        .read_data(cdc_fifo_out),
        .fifo_full(i_q_data_fifo_full),
        .fifo_empty(i_q_data_fifo_empty)
	);

    dsp_top dsp (
        .clk(dsp_clk),
        .rst_n(rst_n),
        .msg_in(~CSN),		        // This might be wrong
        .sample_rate(sample_rate),
        .data_in_i(cdc_fifo_out[7:4]),
        .data_in_q(cdc_fifo_out[3:0]),
        .new_symbol(I || Q),        // This may also need to be set in tb
        .coeff_rw(coeff_rw),		// SPI CDC output
        .coeff_addr(coeff_addr),	// SPI CDC output/output
        .coeff_in(coeff_in),		// SPI CDC output
        .I_out(I_out),
        .Q_out(Q_out),
        .coeff_read_out(coeff_read_out) // SPI CDC input
    );

endmodule
