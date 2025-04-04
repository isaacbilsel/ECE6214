`timescale 1ns / 1ps

module TopModule_tb;
    
    // Testbench Signals
    reg clk;
    // reg upsample_clk;
    reg rst_n;
    reg [3:0] data_in;
    reg coeff_write;
    reg [6:0] coeff_addr;
    reg [7:0] coeff_in;
	reg [3:0] sample_rate;
	reg new_symbol;
    wire [11:0] data_out;
    wire data_out_valid;

     
    // Instantiate the DUT (Device Under Test)
    TopModule dut (
        .clk(clk),
        .rst_n(rst_n),
        .sample_rate(sample_rate),
        .data_in(data_in),
        .new_symbol(new_symbol),
        .coeff_write(coeff_write),
        .coeff_addr(coeff_addr),
        .coeff_in(coeff_in),
        .data_out(data_out),
        .data_out_valid(data_out_valid)
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
		
		// generate data to write into coeff memory
		for (i=0; i <=70; i = i+1) begin
			coeff_write = 1'b1;
			coeff_addr  = i;
			coeff_in    = i;
			@(negedge clk);	 
		end

		coeff_write = 1'b0;

		// flush the pipeline
		repeat(10) @(posedge clk);

		// simulate impulse response  
		testcase = "Impulse";
		@(negedge clk);
		data_in = 4'h1;
		new_symbol = 1'b1;
		repeat (2)@(negedge clk);
		data_in = 4'h0;
		new_symbol = 1'b0;
		@(negedge clk);
		repeat(150)
		@(posedge clk);
		@(negedge clk);	
		
		// simulate step response
		testcase = "Step";
		new_symbol = 1'b1;
		data_in = 4'h1;
		repeat(150)
		@(posedge clk);

		// flush the pipeline
		data_in = 4'h0;
		repeat(150)
		@(posedge clk);
		$finish;
    end
    
endmodule
