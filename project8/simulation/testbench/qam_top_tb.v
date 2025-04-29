`timescale 1ns / 1ps
module qam_top_tb;
	reg 	dsp_clk;
	reg 	data_clk;
	reg         SCLK;
	reg		    MOSI;
	reg		    CSN;
	reg		    rst_n;
	wire		MISO;
	wire		MISO_enable;
	wire [9:0] 	I_out;
	wire [9:0] 	Q_out;

	//Simulation control
	reg [7:0]	    error_count;
	reg [8*39:0]	testcase;
	reg [7:0] spi_data_out;

	// Data generated save in
	// reg [7:0]	    SPI_Data[0:20];

	//loop variable
	integer	    i;

	//instantiation
	qam_top DUT(
		.SCLK(SCLK),
		.data_clk(data_clk),
		.dsp_clk(dsp_clk),
		.MOSI(MOSI),
		.CSN(CSN),
		.rst_n(rst_n),
		.MISO(MISO),
		.MISO_enable(MISO_enable),
		.I_out(I_out),
		.Q_out(Q_out)
	);
	
	always #5000 SCLK = ~SCLK; 			// 100kHz
	always #8.333 data_clk = ~data_clk;	// 60 MHz
	always #3.846 dsp_clk = ~dsp_clk;	// 130 MHz
    
    reg [8*39:0] testcase;
    integer i;

	localparam SPI_WRITE = 1'b1;
    localparam SPI_READ  = 1'b0;

	initial begin
		testcase <= "Initializing";
		rst_n <= 1'b0;
		SCLK  <= 1'b0;
		MOSI  <= 1'b0;
		CSN   <= 1'b1;
		data_in <= 1'b0;
		@(posedge SCLK);
		rst_n <= 1'b1;
		@(posedge SCLK);

		// Test Writing Coefficients
		testcase = "COEFF_WRITE";
		// Write I coefficients to memory
        @(negedge SCLK);
		for (i=0; i<=70; i=i+1) begin
            SPI_CMD(SPI_WRITE, i+128, Icoeff[i], spi_data_out);
			@(negedge SCLK);	 
		end

		// Write Q coefficients to memory
        @(posedge SCLK);
		for (i=0; i<=70; i=i+1) begin
            SPI_CMD(SPI_WRITE, i+256, Qcoeff[i], spi_data_out);
			@(posedge SCLK);	 
		end
		repeat(3) @(posedge SCLK);

		// Test Reading Coefficients
		testcase = "COEFF_READ";
		SPI_CMD(SPI_WRITE, 10'd133, 8'b0, spi_data_out); // This is 5th  addr of I coeff mem: oxFD
		@(posedge SCLK);
		SPI_CMD(SPI_WRITE, 10'd266, 8'b0, spi_data_out); // This is 10th addr of Q coeff mem: 0x02
		@(posedge SCLK);

		// Data is ready to be sent to filter
		testcase = "DATASTREAM";
        @(negedge data_clk);
        for (i=779; i>=0; i=i-1) begin
            data_in <= datastream[i]; 
            @(negedge data_clk);
        end

		// Test reading sample storage
		testcase <= "OUTPUT_READ"; 
		SPI_CMD(SPI_READ, 10'd532, 8'b0, spi_data_out); // This is 10th addr of I output mem (8 MSBs)
		@(posedge SCLK);
		SPI_CMD(SPI_READ, 10'd532, 8'b0, spi_data_out); // This is 10th addr of I output mem (4 LSBs)
		@(posedge SCLK);
    	$finish;
   	end // initial begin


   	task SPI_CMD(
		input         SPI_read_write,
		input  [9:0]  SPI_addr,
		input  [7:0] SPI_Data_in,
		output [7:0] SPI_Data_out
	);

    integer	i;
    begin
		// CSN activation at clock negative edge, send read/write bit
		@(negedge SCLK)
		CSN = 1'b0;

		MOSI = SPI_read_write;
		@(posedge SCLK)
		SCLK = 1'b1;

		// 10-bit address shifted on clock negedge, send SCLK aligned with tb_clk
		for(i = 9; i >= 0; i = i - 1)begin
			@(negedge SCLK) 
				SCLK = 1'b0;
			MOSI = SPI_addr[i];
			@(posedge SCLK)
				SCLK = 1'b1;
		end

		// 9-bit dead time for data retrieval
		for(i = 8; i >= 0; i = i - 1)begin
			@(negedge SCLK)
			SCLK = 1'b0;
			MOSI = 1'b0;
			@(posedge SCLK)
			SCLK = 1'b1;
		end

		// 8-bit data shifted on clock negedge, send SCLK aligned with tb_clk
		for(i = 7; i >= 0; i = i - 1) begin
			@(negedge tb_clk)
			SCLK = 1'b0;
			if(SPI_read_write == 1'b1)begin
			MOSI =  SPI_Data_in[i];
			end 
			else begin
			MOSI = 1'b0;
			end

			@(posedge tb_clk)
			SCLK = 1'b1;
			//clock in data on MISO if MISO_enable = 1, else clock in that it is a high-z
			if(MISO_enable == 1'b1)begin
			SPI_Data_out[i] = MISO;
			end 
			else begin
			SPI_Data_out[i] = 1'bz;
			end
		end 

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
