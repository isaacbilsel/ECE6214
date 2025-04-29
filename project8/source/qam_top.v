`timescale 1ns / 1ps
module qam_top(
	// Clocks
	input wire SCLK,
	input wire dsp_clk,
	input wire data_clk,
	// SPI interface
	input wire MOSI,
	input wire MISO,
	input wire MISO_enable,
	input wire CSN,
	// Data interface
	input wire rst_n,
	input wire data_in,
	output wire [9:0] I_out,
	output wire [9:0] Q_out
);

	/* ******** INTERNAL SIGNALS **********/
	// Reset signals
	wire rst_n_spi;
	wire rst_n_data;
	wire rst_n_dsp;

	// SPI to DSP signals
	wire [7:0]			       reg_read_data;
	wire [9:0]			       reg_address;
	wire [7:0]			       reg_write_data;
	wire				       reg_write_enable;
	wire				       reg_read_enable;
	wire rw_enable;
	assign rw_enable = reg_read_enable ? 1'b0 : (reg_write_enable ? 1'b1 : 1'b0);
	wire rw_dsp; 
	wire [9:0] mem_addr;
	wire [7:0] coeff_in;
	wire mem_read_out;

	// Signals for CDC FIFO and baseband->dsp communication
    wire [7:0] cdc_fifo_out;
    wire i_q_data_fifo_full;
    wire signed [3:0] i_data;
    wire signed [3:0] q_data;
    wire new_symbol;


	/* ******** INSTANTIATE SUBMODULES **********/
	// Reset synchronization
    reset_synchronization rst_spi (
		.clk(SCLK),
		.rst_n(rst_n & rst_n_spi),
		.rst_n_sync(rst_n_spi)
    );
	reset_synchronization rst_data(
		.clk(data_clk),
		.rst_n(rst_n & rst_n_spi),
		.rst_n_sync(rst_n_data)
    );
	reset_synchronization rst_dsp(
		.clk(dsp_clk),
		.rst_n(rst_n & rst_n_data),
		.rst_n_sync(rst_n_spi)
    );

	SPI_Interface cmd_interface(
		.SCLK(SCLK),
		.MOSI(MOSI),
		.CSN(CSN),
		.rst_n(rst_n_spi),
		.reg_read_data(reg_read_data),
		.MISO(MISO),
		.MISO_enable(MISO_enable),
		.reg_address(reg_address),
		.reg_write_data(reg_write_data),
		.reg_write_enable(reg_write_enable),
		.reg_read_enable(reg_read_enable)
	);

	multicycle_data_top #(.DATA_WIDTH(19)) spi_to_dsp (
		.aclk(SCLK),
		.bclk(dsp_clk),
		.rst_n(rst_n_spi),
		.data_in({rw_enable}, {reg_address}, {reg_write_data}),
		.load_data(reg_address != 0),	// This needs to be fixed
		.data_out({rw_dsp}, {mem_addr}, {coeff_in})
	);

	multicycle_data_top #(.DATA_WIDTH(8)) spi_to_dsp (
		.aclk(dsp_clk),
		.bclk(SCLK),
		.rst_n(rst_n_dsp),
		.data_in(mem_read_out),
		.load_data(reg_read_enable),	// This needs to be fixed
		.data_out(reg_read_data)
	);

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
        .rst_n_write(rst_n_data), 
        .rst_n_read(rst_n_dsp),  
        .write_data({i_data, q_data}),
        .write_enable(new_symbol),
        .read_enable(rst_n_dsp),          // Not sure how to assign this signal
        .read_data(cdc_fifo_out),
        .fifo_full(i_q_data_fifo_full),
        .fifo_empty(i_q_data_fifo_empty)
	);

    dsp_top dsp (
        .clk(dsp_clk),
        .rst_n(rst_n_dsp),
        .msg_in(msg_in),			// !
        .sample_rate(sample_rate),
        .data_in_i(cdc_fifo_out[7:4]),
        .data_in_q(cdc_fifo_out[3:0]),
        .new_symbol(cdc_fifo_out != 0),        	//!
        .rw(rw_dsp),		
        .mem_addr(mem_addr),	
        .coeff_in(coeff_in),		
        .I_out(I_out),
        .Q_out(Q_out),
        .mem_read_out(mem_read_out) 
    );

endmodule // qam_top
