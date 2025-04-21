`timescale 1ns / 1ps

module sample_storage_tb
    reg  clk,
    reg  rst_n,   
	reg signed [11:0]  sample_in,
	reg [9:0] 	    sample_addr,
	reg 		  sample_read,
    reg         counter_begin,   // Signal to start writing to sample storage
	wire signed [7:0] sample_read_out

    sample_storage DUT(
        .clk(clk),
        .rst_n(rst_n),
        .sample_in(sample_in),
        .sample_addr(sample_addr),
        .sample_read(sample_read),
        .counter_begin(counter_begin),
        .sample_read_out(sample_read_out)
    )

    always #5 clk = ~clk; 	// 10 ns clock

    initial begin
        clk <= 0;
		rst_n <= 0;
		repeat(2) @(posedge clk);
		rst_n = 1;
		repeat(2) @(posedge clk);

        counter_begin <= 1'b1;
        sample_in <= 1;
        
        @negedge clk;
        sample_in <= 2;
        @negedge clk;
        sample_in <= 3;
        @negedge clk;
        sample_in <= 4;
        @negedge clk;
        sample_in <= 5;
        @negedge clk;
        sample_in <= 6;
        @negedge clk;
        sample_in <= 7;

        repeat(2) @negedge clk;

        // Test reading output memory
		// Should read 5th output 
		msg_in = 1'b1;
		sample_read <= 1'b0;
		mem_addr  <= 5;
		
		repeat(2) @(posedge clk);
		msg_in = 1'b0;
		repeat(3) @(posedge clk);
    end

endmodule