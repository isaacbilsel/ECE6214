`timescale 1ns / 1ps
module 64QAM_Modulator_top_tb(
			      );
   //SPI interface_signals
   reg                        SCLK  = 1'b0;
   reg		    MOSI  = 1'b0;
   reg		    CSN   = 1'b1;
   reg		    rst_n = 1'b0;
   wire		    MISO;
   wire		    MISO_enable;

   //SPI data output
   reg [15:0]	    SPI_Data_out;

   //Simulation control
   reg		    tb_clk = 1'b0;
   reg [7:0]	    error_count;
   reg [8*39:0]	    testcase;

   // Data generated save in
   reg [15:0]	    SPI_Data[0:255];

   //loop variable
   integer	    i;

   //instantiation
   64QAM_Modulator_top DUT(
			   .SCLK(SCLK),
			   .MOSI(MOSI),
			   .CSN(CSN),
			   .rst_n(rst_n),
			   .MISO(MISO),
			   .MISO_enable(MISO_enable)
			   );

   // 100kHz clk = 10000ns period
   always #5000 tb_clk = ~tb_clk;

   initial begin
      testcase = "Initializing";
      repeat(10) 
	@(posedge tb_clk);
      rst_n = 1'b1;

      // generate spi data to write and read back
      for(i = 0; i <= 255; i = i + 1)begin
	 SPI_Data[i] = $random;
      end

      repeat(10)
	@(posedge tb_clk);

      // write all 256 registers
      testcase = "SPI_WRITE";
      for(i = 0; i <= 255; i = i + 1)begin
	 SPI_CMD(1'b1, i, SPI_Data[i], SPI_Data_out);
      end

      repeat(10)
	@(posedge tb_clk);

      // read all 256 registers
      testcase = "SPI_READ";
      for(i = 0; i <= 255; i = i + 1)begin
	 SPI_CMD(1'b0, i, SPI_Data[i], SPI_Data_out);
	 error_count = compare_outputs(SPI_Data[i], SPI_Data_out, i, error_count);
      end

      repeat(20)
	@(posedge tb_clk);

      $finish;
   end // initial begin


   task SPI_CMD(
		input         SPI_read_write,
		input  [7:0]  SPI_addr,
		input  [15:0] SPI_Data_in,
		output [15:0] SPI_Data_out
		);

      integer		      i;
      
      begin

	 // CSN activation at clock negative edge, send read/write bit
	 @(negedge tb_clk)
	   CSN = 1'b0;

	 MOSI = SPI_read_write;
	 @(posedge tb_clk)
	   SCLK = 1'b1;

	 // 8-bit address shifted on clock negedge, send SCLK aligned with tb_clk
	 for(i = 7; i >= 0; i = i - 1)begin
	    @(negedge tb_clk)
	      SCLK = 1'b0;
	    MOSI = SPI_addr[i];
	    @(posedge tb_clk)
	      SCLK = 1'b1;
	 end

	 // 5-bit dead time for data retrieval
	 for(i = 4; i >= 0; i = i - 1)begin
	    @(negedge tb_clk)
	      SCLK = 1'b0;
	    MOSI = 1'b0;
	    @(posedge tb_clk)
	      SCLK = 1'b1;
	 end

	 // 16-bit data shifted on clock negedge, send SCLK aligned with tb_clk
	 for(i = 15; i >= 0; i = i - 1) begin
	    @(negedge tb_clk)
	      SCLK = 1'b0;
	    if(SPI_read_write == 1'b1)begin
	       MOSI =  SPI_Data_in[i];
	    end else begin
	       MOSI = 1'b0;
	    end

	    @(posedge tb_clk)
	      SCLK = 1'b1;
	    //clock in data on MISO if MISO_enable = 1, else clock in that it is a high-z
	    if(MISO_enable == 1'b1)begin
	       SPI_Data_out[i] = MISO;
	    end else begin
	       SPI_Data_out[i] = 1'bz;
	    end
	 end // for (i = 15; i >= 0; i = i - 1)

	 // 4-bit dead time for data write
	 for(i = 4; i >= 0; i = i - 1)begin
	    @(negedge tb_clk)
	      SCLK = 1'b0;
	    MOSI = 1'b0;
	    @(posedge tb_clk)
	      SCLK = 1'b1;
	 end

	 // end message and CSN goes inactive
	 SCLK = 1'b0;
	 CSN = 1'b1;

      end
      
   endtask // SPI_CMD

   function [7:0] compare_outputs(
				     input [15:0] expected_value,
				     input [15:0] actual_value,
				     input [7:0] address,
				     input [7:0] error_count
				     );
      if(expected_value == actual_value)begin
	 $display("PASS =  %b, Expected = %b, Actual = %b, Time = %t", address, expected_value, actual_value, $time);
	 compare_outputs = error_count;
      end else begin
	 $display("FAIL** = %b, Expected = %b, Actual = %b, Time = %t", address, expected_value, actual_value, $time);
	 compare_outputs = error_count + 1;
      end
   endfunction // compare_outputs
   endmodule // 64QAM_Modulator_top_tb

/*
`timescale 1ns / 1ps
module modulator_64qam_top_tb(
 
);
 //SPI interface_signals
 reg SCLK = 1'b0;
 reg MOSI = 1'b0;
 reg CSN = 1'b1;
 reg rst_n = 1'b0;
 wire MISO;
 wire MISO_enable;
 // signal for SPI data output
 reg [7:0] SPI_data_out;
 //signals for simulation control
 reg tb_clk = 1'b0;
 reg [7:0] error_count;
 reg [8*39:0] testcase;
 // signal to save generated data in
 reg [7:0] spi_data[0:255];
 //loop variables
 integer i;
 //instantiate DUT

 modulator_64qam_top DUT(
 .SCLK(SCLK),
 .MOSI(MOSI),
 .CSN(CSN),
 .rst_n(rst_n),
 .MISO(MISO),
 .MISO_enable(MISO_enable)
 );
 // 100kHz clk = 10 000ns period
 always #5000 tb_clk = ~tb_clk;
 initial begin
 
testcase = "Initializing";
 
repeat(10) 
@(posedge tb_clk);
 
rst_n = 1'b1;
 
// generate spi data to write and read back
for(i = 0; i <= 255; i = i + 1)begin
 spi_data[i] = $random;
end
 
repeat(10)
@(posedge tb_clk);
 
// write to all 256 registers
 
testcase = "SPI_WRITE";
 
for(i = 0; i <= 255; i = i + 1)begin
 SPI_CMD(1'b1, i, spi_data[i], SPI_data_out);
end
 
repeat(10)
@(posedge tb_clk);
 
// read all 256 registers
 
testcase = "SPI_READ";
 
for(i = 0; i <= 255; i = i + 1)begin
 SPI_CMD(1'b0, i, spi_data[i], SPI_data_out);
 error_count = compare_outputs(spi_data[i], SPI_data_out, i, error_count);
 
end
 
repeat(20)
@(posedge tb_clk);
 $finish; 
 end // initial begin
 task SPI_CMD(
input 
SPI_read_write,
input [9:0] SPI_addr,
input [7:0] SPI_data_in,
output [7:0] SPI_data_out
);
 
integer 
i;

 
begin
 // active-low CSN active at clock negative edge, send read/write bit
 @(negedge tb_clk)
 CSN = 1'b0;
 MOSI = SPI_read_write;
 @(posedge tb_clk)
 SCLK = 1'b1;
 // 10-bit address shifted on clock negedge, send SCLK aligned with tb_clk
 for(i = 9; i >= 0; i = i - 1)begin
 @(negedge tb_clk)
 
SCLK = 1'b0;
 MOSI = SPI_addr[i];
 @(posedge tb_clk)
 
SCLK = 1'b1;
 end
 // 9-bit dead time for data retrieval
 for(i = 8; i >= 0; i = i - 1)begin
 @(negedge tb_clk)
 
SCLK = 1'b0;
 MOSI = 1'b0;
 @(posedge tb_clk)
 
SCLK = 1'b1;
 end
 // 8-bit data shifted on clock negedge, send SCLK aligned with tb_clk

 for(i = 7; i >= 0; i = i - 1) begin
 @(negedge tb_clk)
 
SCLK = 1'b0;
 if(SPI_read_write == 1'b1)begin
 
MOSI = SPI_data_in[i];
 end else begin
 
MOSI = 1'b0;
 end
 @(posedge tb_clk)
 
SCLK = 1'b1;
 //clock in data on MISO if MISO_enable = 1, else clock in that it is a high-z
 if(MISO_enable == 1'b1)begin
 
SPI_data_out[i] = MISO;
 end else begin
 
SPI_data_out[i] = 1'bz;
 end
 end // for (i = 7; i >= 0; i = i - 1)
 // 6-bit dead time for data write
 for(i = 5; i >= 0; i = i - 1)begin
 @(negedge tb_clk)
 
SCLK = 1'b0;
 MOSI = 1'b0;
 @(posedge tb_clk)
 
SCLK = 1'b1;
 end
 // end message and CSN goes inactive

 SCLK = 1'b0;
 CSN = 1'b1;
 
end
 
 endtask // SPI_CMD
 function [7:0] compare_outputs(
 
input [7:0] expected_value,
input [7:0] actual_value,
input [9:0] address,
input [7:0] error_count
 
);
 
if(expected_value == actual_value)begin
 $display("PASS = %b, Expected = %b, Actual = %b, Time = %t", address, 
expected_value, actual_value, $time);
 compare_outputs = error_count;
 
end else begin
 $display("FAIL** = %b, Expected = %b, Actual = %b, Time = %t", address, 
expected_value, actual_value, $time);
 compare_outputs = error_count + 1;
 
end
 endfunction // compare_outputs
 
 
endmodule // modulator_64qam_top_tb
*/