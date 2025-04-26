`timescale 1ns / 1ps

module sample_storage_tb;
    reg  clk;
    reg  rst_n;   
	reg signed [11:0]  sample_in;
	reg [9:0] 	    sample_addr;
	reg 		  sample_read;
    reg         counter_begin;   // Signal to start writing to sample storage
	wire signed [7:0] sample_read_out;

    sample_storage DUT(
        .clk(clk),
        .rst_n(rst_n),
        .sample_in(sample_in),
        .sample_addr(sample_addr),
        .sample_read(sample_read),
        .counter_begin(counter_begin),
        .sample_read_out(sample_read_out)
    );
    
    // initial block for SDF back annotation
	initial begin
		$sdf_annotate("../../synthesis/netlists/sample_storage_syn.sdf" , sample_storage_tb.DUT, ,"back_annotate.log");
	end

    always #5 clk = ~clk; 	// 10 ns clock
	integer i;
    initial begin
        clk <= 0;
		rst_n <= 0;
		sample_read <= 1'b0;
		repeat(2) @(posedge clk);
		rst_n = 1;
		repeat(2) @(posedge clk);
		@(negedge clk);
        counter_begin <= 1'b1;
        
        for (i=0; i <=19; i = i+1) begin
        	sample_in <= i;
			@(negedge clk);	 
		end
		
		// Simulate invalid outputs. These should not be written to storage.
        counter_begin <= 1'b0;
        for (i=20; i <=25; i = i+1) begin
        	sample_in <= i;
			@(negedge clk);	 
		end
		
		counter_begin <= 1'b1;
		for (i=26; i <=63; i = i+1) begin
        	sample_in <= i;
			@(negedge clk);	 
		end
        
        
		repeat(2) @(posedge clk);
        // Test reading output memory
		// Should read 5th output 
		sample_read <= 1'b1;
		sample_addr  <= 5;
		repeat(2) @(posedge clk);
		
		// Should read 10th output 
		sample_read <= 1'b1;
		sample_addr  <= 10;
		repeat(2) @(posedge clk);
		
		$finish;
    end

endmodule
