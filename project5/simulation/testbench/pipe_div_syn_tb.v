`timescale 10ns / 10ps 

module pipe_div_tb;

    reg clk;
    reg rst_n;
    reg signed [15:0] dividend;
	reg signed [7:0] divisor;
	wire signed [15:0] quotient;
	wire signed [7:0] remainder;
	wire ready;

    // Instantiate the multiplier module
    pipe_div DUT (
        .clk(clk),
        .rst_n(rst_n),
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder),
        .ready(ready),
        .error(error)
    );

	// initial block for SDF back annotation
	initial begin
		$sdf_annotate("../../synthesis/netlists/pipe_div_syn.sdf" , pipe_div_tb.DUT, ,"back_annotate.log");
   end

    // Generate clock with 10ns period
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        clk <= 0;
        rst_n <= 0;
        dividend <= 0;
        divisor <= 0;
        repeat(2)@(negedge clk);

        rst_n = 1;  // Release reset
		repeat(2)@(negedge clk);
		
        // Simple Division Test Cases
       	
       	// 13 % 2
		dividend <= 16'h000D; 
		divisor <= 8'h02; 	
		wait (ready == 1'b1);
		$display("Time %t: dividend = %d, divisor = %d, quotient = %d, remainder = %d, ERROR = %d", $time, dividend, divisor, quotient, remainder, error);
		repeat(1)@(negedge clk);
		
		rst_n = 0;	// Reset 
		repeat(1)@(negedge clk);
		
		// 1789 % 122
       	dividend <= 16'h06FD; 
		divisor <= 8'h7A; 	
		rst_n 	<= 1;
		wait (ready == 1'b1);
		$display("Time %t: dividend = %d, divisor = %d, quotient = %d, remainder = %d, ERROR = %d", $time, dividend, divisor, quotient, remainder, error);
		repeat(1)@(negedge clk);
		
		rst_n = 0;	// Reset 
		repeat(1)@(negedge clk);
		
		// -13 % 2
		dividend <= 16'hFFF3; 
		divisor <= 8'h02; 	
		rst_n 	<= 1;
		wait (ready == 1'b1);
		$display("Time %t: dividend = %d, divisor = %d, quotient = %d, remainder = %d, ERROR = %d", $time, dividend, divisor, quotient, remainder, error);
		repeat(1)@(negedge clk);
		
		rst_n = 0;	// Reset
		repeat(1)@(negedge clk);
		
		// 1917 % -37
		dividend <= 16'h077D; 
		divisor <= 8'hDB; 	
		rst_n 	<= 1;
		wait (ready == 1'b1);
		$display("Time %t: dividend = %d, divisor = %d, quotient = %d, remainder = %d, ERROR = %d", $time, dividend, divisor, quotient, remainder, error);
		repeat(1)@(negedge clk);
		
		rst_n = 0;	// Reset
		repeat(1)@(negedge clk);
		
		// -1905 % -33
		dividend <= 16'hF88F; 
		divisor <= 8'hDF; 	
		rst_n 	<= 1;
		wait (ready == 1'b1);
		$display("Time %t: dividend = %d, divisor = %d, quotient = %d, remainder = %d, ERROR = %d", $time, dividend, divisor, quotient, remainder, error);
		repeat(1)@(negedge clk);
		
		rst_n = 0;	// Reset
		repeat(1)@(negedge clk);

		// Test division by 0 edge case
		// 13 % 0
		dividend <= 16'h000D; 
		divisor <= 8'h00; 	
		rst_n 	<= 1;
		wait (error == 1'b1);
		$display("Time %t: dividend = %d, divisor = %d, quotient = %d, remainder = %d, ERROR = %d", $time, dividend, divisor, quotient, remainder, error);
		repeat(2)@(negedge clk);
        $finish; // End simulation
    end

endmodule
