`timescale 1ns / 1ps
module modulator_64qam_top(
			   input wire SCLK,
			   input wire MOSI,
			   input wire CSN,
			   input wire rst_n,
			   output wire MISO,
			   output wire MISO_enable
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

/*
//spi interface
   spi_interface u_spi_interface(
				 .SCLK(SCLK),
				 .MOSI(MOSI),
				 .CSN(CSN),
				 .rst_n(rst_n_SPI),
				 .reg_read_data(read_data_sync_spi),
				 .mapping(mapping_sync_spi),
				 .reg_addr_fifo_full(reg_addr_fifo_full),
				 .read_data_fifo_empty(read_data_fifo_empty),
				 .read_data_read_ready(read_data_write_enable_sync_SPI), 
				 .write_data_fifo_full(write_data_fifo_full),
				 .MISO(MISO),
				 .MISO_enable(MISO_enable),
				 .enable(enable),
				 .reg_addr(reg_addr),
				 .reg_write_data(write_data),
				 .reg_write_enable(write_enable),
				 .reg_read_enable(read_enable),
				 .read_data_read_enable(read_data_read_enable)
				 );

*/

   register_array memory_array(
			       .SCLK(SCLK),
			       .rst_n(rst_n),
			       .reg_address(reg_address),
			       .reg_write_data(reg_write_data),
			       .reg_write_enable(reg_write_enable),
			       .reg_read_enable(reg_read_enable),
			       .reg_read_data(reg_read_data)
			       );
endmodule // 64QAM_Modulator_top


