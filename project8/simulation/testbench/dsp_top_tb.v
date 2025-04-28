`timescale 1ns / 1ps

module dsp_top_tb;
    
    // Testbench Signals
    reg clk;
    // reg upsample_clk;
    reg rst_n;
    reg [3:0] data_in_i;
	reg [3:0] data_in_q;
    reg rw;
    reg [9:0] mem_addr;
    reg [7:0] coeff_in;
	reg [3:0] sample_rate;
	reg new_symbol;
	reg msg_in;
    wire [9:0] I_out;
	wire [9:0] Q_out;
	wire [7:0] mem_read_out;
     
    // Instantiate the DUT (Device Under Test)
    dsp_top dut (
        .clk(clk),
        .rst_n(rst_n),
		.msg_in(msg_in),
        .sample_rate(sample_rate),
        .data_in_i(data_in_i),
		.data_in_q(data_in_q),
        .new_symbol(new_symbol),
        .rw(rw),
        .mem_addr(mem_addr),
        .coeff_in(coeff_in),
        .I_out(I_out),
		.Q_out(Q_out),
		.mem_read_out(mem_read_out)
    );
    
    // Clock frequency: 40MhZ - 130MHz
    // Clock Period: 25 ns -7.7 ns
    // always #5 upsample_clk = ~upsample_clk; 
    always #5 clk = ~clk; 	// 10 ns clock

	// testbench signals
	reg [8*39:0]       testcase;
	integer 	      i;

	reg [7:0] Icoeff [0:70];
	reg [7:0] Qcoeff [0:70];
	
    // Testbench Procedure
    initial begin
		testcase = "Initializing";
		clk <= 0;
		rst_n <= 0;
		sample_rate <= 4'd13;
		repeat(2) @(posedge clk);
		rst_n = 1;
		repeat(2) @(posedge clk);
		
		// generate data to write into I coeff memory
		for (i=0; i <=70; i = i+1) begin
			msg_in <= 1'b1;
			rw <= 1'b1;
			mem_addr  <= i + 128;
			coeff_in  <= Icoeff[i];
			@(negedge clk);	 
		end

		// generate data to write into Q coeff memory
		for (i=0; i <=70; i = i+1) begin
			msg_in <= 1'b1;
			rw <= 1'b1;
			mem_addr  <= i + 256;
			coeff_in  <= Qcoeff[i];
			@(negedge clk);	 
		end
		msg_in = 1'b0;

		// flush the pipeline
		repeat(5) @(posedge clk);

		// Test reading coeff I memory
		// coeff_read_out should set to 5
		msg_in <= 1'b1;
		rw <= 1'b0;
		mem_addr  <= 133;
		
		repeat(2) @(posedge clk);
		msg_in = 1'b0;
		repeat(3) @(posedge clk);

		// Test reading coeff Q memory
		// coeff_read_out should set to 10
		msg_in <= 1'b1;
		rw <= 1'b0;
		mem_addr  <= 266; 
		repeat(3) @(posedge clk);

		// flush the pipeline
		repeat(10) @(posedge clk);

		@(negedge clk);	
		// simulate step response
		testcase <= "Step";
		new_symbol <= 1'b1;
		data_in_i <= 4'h1;
		
		repeat(150) @(negedge clk);	// This should feed in the equivalent of 11 samples to the filter
		new_symbol <= 1'b0;
		data_in_i <= 4'h0;

		// flush the pipeline
		repeat(160) @(posedge clk);
		
		// Test reading I output memory
		// Should read 0th output 
		msg_in <= 1'b1;
		rw <= 1'b0;
		// Read first 8 MSBs
		mem_addr  <= 512;
		
		// Read last 4 LSBs
		repeat(1) @(posedge clk);
		mem_addr  <= 513;
		
		repeat(2) @(posedge clk);
		msg_in = 1'b0;
		
		repeat(3) @(posedge clk);

		// Test reading I output memory
		// Should read 10th output 
		msg_in <= 1'b1;
		rw <= 1'b0;
		mem_addr  <= 532;
		
		// Read last 4 LSBs
		repeat(1) @(posedge clk);
		mem_addr  <= 533;
		
		repeat(3) @(posedge clk);

		// TO DO: Test Q memory reads as well 
		
		// simulate impulse response  
		testcase = "Impulse";
		@(negedge clk);
		data_in_i <= 4'h1;
		new_symbol <= 1'b1;
		repeat (2) @(negedge clk);
		data_in_i <= 4'h0;
		new_symbol <= 1'b0;
		@(negedge clk);
		repeat(150) @(posedge clk);
		
		rst_n <= 0;
		repeat(2) @(posedge clk);
		rst_n = 1;
		repeat(2) @(posedge clk);
		// Send in datastream with 12 bit header
        testcase <= "Datastream";    
        @(negedge data_clk);
        for (i=779; i>=775; i=i-1) begin
            data_in <= datastream[i]; 
            @(negedge data_clk);
        end
		$finish;
		
		// We need to write to the log file here
    end

	initial begin
	// I filter coefficients
		Icoeff[0] <= 8'h00;
		Icoeff[1] <= 8'h00;
		Icoeff[2] <= 8'hFF;
		Icoeff[3] <= 8'hFE;
		Icoeff[4] <= 8'hFE;
		Icoeff[5] <= 8'hFD;
		Icoeff[6] <= 8'hFE;
		Icoeff[7] <= 8'hFE;
		Icoeff[8] <= 8'hFF;
		Icoeff[9] <= 8'h00;
		Icoeff[10] <= 8'h02;
		Icoeff[11] <= 8'h03;
		Icoeff[12] <= 8'h03;
		Icoeff[13] <= 8'h03;
		Icoeff[14] <= 8'h02;
		Icoeff[15] <= 8'h01;
		Icoeff[16] <= 8'hFE;
		Icoeff[17] <= 8'hFB;
		Icoeff[18] <= 8'hF8;
		Icoeff[19] <= 8'hF5;
		Icoeff[20] <= 8'hF3;
		Icoeff[21] <= 8'hF3;
		Icoeff[22] <= 8'hF4;
		Icoeff[23] <= 8'hF7;
		Icoeff[24] <= 8'hFE;
		Icoeff[25] <= 8'h07;
		Icoeff[26] <= 8'h12;
		Icoeff[27] <= 8'h20;
		Icoeff[28] <= 8'h30;
		Icoeff[29] <= 8'h40;
		Icoeff[30] <= 8'h51;
		Icoeff[31] <= 8'h60;
		Icoeff[32] <= 8'h6D;
		Icoeff[33] <= 8'h77;
		Icoeff[34] <= 8'h7D;
		Icoeff[35] <= 8'h7F;
		Icoeff[36] <= 8'h7D;
		Icoeff[37] <= 8'h77;
		Icoeff[38] <= 8'h6D;
		Icoeff[39] <= 8'h60;
		Icoeff[40] <= 8'h51;
		Icoeff[41] <= 8'h40;
		Icoeff[42] <= 8'h30;
		Icoeff[43] <= 8'h20;
		Icoeff[44] <= 8'h12;
		Icoeff[45] <= 8'h07;
		Icoeff[46] <= 8'hFE;
		Icoeff[47] <= 8'hF7;
		Icoeff[48] <= 8'hF4;
		Icoeff[49] <= 8'hF3;
		Icoeff[50] <= 8'hF3;
		Icoeff[51] <= 8'hF5;
		Icoeff[52] <= 8'hF8;
		Icoeff[53] <= 8'hFB;
		Icoeff[54] <= 8'hFE;
		Icoeff[55] <= 8'h01;
		Icoeff[56] <= 8'h02;
		Icoeff[57] <= 8'h03;
		Icoeff[58] <= 8'h03;
		Icoeff[59] <= 8'h03;
		Icoeff[60] <= 8'h02;
		Icoeff[61] <= 8'h00;
		Icoeff[62] <= 8'hFF;
		Icoeff[63] <= 8'hFE;
		Icoeff[64] <= 8'hFE;
		Icoeff[65] <= 8'hFD;
		Icoeff[66] <= 8'hFE;
		Icoeff[67] <= 8'hFE;
		Icoeff[68] <= 8'hFF;
		Icoeff[69] <= 8'h00;
		Icoeff[70] <= 8'h00;

	// Q filter coefficients
		Qcoeff[0] <= 8'h00;
		Qcoeff[1] <= 8'h00;
		Qcoeff[2] <= 8'hFF;
		Qcoeff[3] <= 8'hFE;
		Qcoeff[4] <= 8'hFE;
		Qcoeff[5] <= 8'hFD;
		Qcoeff[6] <= 8'hFE;
		Qcoeff[7] <= 8'hFE;
		Qcoeff[8] <= 8'hFF;
		Qcoeff[9] <= 8'h00;
		Qcoeff[10] <= 8'h02;
		Qcoeff[11] <= 8'h03;
		Qcoeff[12] <= 8'h03;
		Qcoeff[13] <= 8'h03;
		Qcoeff[14] <= 8'h02;
		Qcoeff[15] <= 8'h01;
		Qcoeff[16] <= 8'hFE;
		Qcoeff[17] <= 8'hFB;
		Qcoeff[18] <= 8'hF9;
		Qcoeff[19] <= 8'hF6;
		Qcoeff[20] <= 8'hF4;
		Qcoeff[21] <= 8'hF4;
		Qcoeff[22] <= 8'hF5;
		Qcoeff[23] <= 8'hF8;
		Qcoeff[24] <= 8'hFE;
		Qcoeff[25] <= 8'h06;
		Qcoeff[26] <= 8'h10;
		Qcoeff[27] <= 8'h1D;
		Qcoeff[28] <= 8'h2B;
		Qcoeff[29] <= 8'h3A;
		Qcoeff[30] <= 8'h49;
		Qcoeff[31] <= 8'h56;
		Qcoeff[32] <= 8'h62;
		Qcoeff[33] <= 8'h6B;
		Qcoeff[34] <= 8'h71;
		Qcoeff[35] <= 8'h72;
		Qcoeff[36] <= 8'h71;
		Qcoeff[37] <= 8'h6B;
		Qcoeff[38] <= 8'h62;
		Qcoeff[39] <= 8'h56;
		Qcoeff[40] <= 8'h49;
		Qcoeff[41] <= 8'h3A;
		Qcoeff[42] <= 8'h2B;
		Qcoeff[43] <= 8'h1D;
		Qcoeff[44] <= 8'h10;
		Qcoeff[45] <= 8'h06;
		Qcoeff[46] <= 8'hFE;
		Qcoeff[47] <= 8'hF8;
		Qcoeff[48] <= 8'hF5;
		Qcoeff[49] <= 8'hF4;
		Qcoeff[50] <= 8'hF4;
		Qcoeff[51] <= 8'hF6;
		Qcoeff[52] <= 8'hF9;
		Qcoeff[53] <= 8'hFB;
		Qcoeff[54] <= 8'hFE;
		Qcoeff[55] <= 8'h01;
		Qcoeff[56] <= 8'h02;
		Qcoeff[57] <= 8'h03;
		Qcoeff[58] <= 8'h03;
		Qcoeff[59] <= 8'h03;
		Qcoeff[60] <= 8'h02;
		Qcoeff[61] <= 8'h00;
		Qcoeff[62] <= 8'hFF;
		Qcoeff[63] <= 8'hFE;
		Qcoeff[64] <= 8'hFE;
		Qcoeff[65] <= 8'hFD;
		Qcoeff[66] <= 8'hFE;
		Qcoeff[67] <= 8'hFE;
		Qcoeff[68] <= 8'hFF;
		Qcoeff[69] <= 8'h00;
		Qcoeff[70] <= 8'h00;
	end
    
endmodule
