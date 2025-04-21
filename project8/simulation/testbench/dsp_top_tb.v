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
			coeff_in    <= i;
			@(negedge clk);	 
		end

		// generate data to write into Q coeff memory
		for (i=0; i <=70; i = i+1) begin
			msg_in <= 1'b1;
			rw <= 1'b1;
			mem_addr  <= i + 256;
			coeff_in    <= i;
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
		
		@(negedge clk);	
		new_symbol <= 1'b0;
		repeat(150) @(posedge clk);

		// flush the pipeline
		data_in_i <= 4'h0;
		repeat(160) @(posedge clk);
		
		// Test reading I output memory
		// Should read 5th output 
		msg_in <= 1'b1;
		rw <= 1'b0;
		mem_addr  <= 516;
		
		repeat(2) @(posedge clk);
		msg_in = 1'b0;
		repeat(3) @(posedge clk);

		// Test reading Q output memory
		// Should read 10th output // doesnt exist right now
		msg_in <= 1'b1;
		rw <= 1'b0;
		mem_addr  <= 778; 
		repeat(3) @(posedge clk);
		
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
		
		$finish;
		
		// We need to write to the log file here
    end
    
endmodule
