`timescale 1ns / 1ps

module divider_syn_tb;
    // Testbench Signals
    reg clk=1;
    reg rst_n;
    reg [15:0] a;
    reg [7:0] b;
    wire [15:0] quotient;
    wire [7:0] remainder;    
    reg [(20*8)-1:0] testcase;
    reg [31:0] error_count = 32'h00000000;

    // Instantiate the multiplier module
    divider_syn DUT (
        .a(a),
        .b(b),
        .quotient(quotient),
        .remainder(remainder),
        .clk(clk),
        .rst_n(rst_n)
    );

 // Clock Generation (100 MHz)
    always #5 clk = ~clk;

// initial block for SDF back annotation
   initial begin
      $sdf_annotate("../../synthesis/netlist/divider_syn.sdf",divider_syn_tb.DUT, ,"back_annotate.log");
   end

   

    // Testbench Logic
    initial begin
        $monitor("Testcase %s | Time = %t | A = %d | B = %d | quotient =%d | remainder = %d", 
                 testcase, $time, a, b, quotient, remainder);

        // Initialize signals
        clk = 1;
        rst_n = 1;
        a = 0;
        b = 1;
        testcase = "Reset_Check";
       

        // Apply Reset
        //#5 rst_n = 0;
        //#10 rst_n = 1;
        //#10 error_count = compare_outputs(8'h00, c, "Product", error_count);

        // Test 1
        testcase = "Test_1";
        a = 16'd25;
        b = 8'd5;
        #25 error_count = compare_outputs(16'h0005, quotient, "quotient", error_count);
        #20 error_count = compare_outputs(16'h0000, remainder, "remainder", error_count);
	

        // Test 2
        testcase = "Test_2";
        a = 16'd34 ;
        b = 8'd16;
        #20 error_count = compare_outputs(16'h0002, quotient, "quotient", error_count);
        #20 error_count = compare_outputs(16'd0002, remainder, "remainder", error_count);

        // Test Summary
        if (error_count == 0) begin
            $display("\n\n----------SIMULATION PASSED----------");
        end else begin
            $display("\n\n----------SIMULATION FAILED----------");
            $display("---------- %d ERRORS TOTAL----------\n\n", error_count);
        end

        $finish;
    end

    // Function to compare expected and actual results
    function [31:0] compare_outputs (
        input [31:0] expected_value,
        input [31:0] actual_value,
        input [8*19:0] signal_name,
        input [31:0] error_count
    );
        if (expected_value == actual_value) begin
            $display("  PASS  : %s: Expected = %d, Actual = %d, Time = %t", 
                      signal_name, expected_value, actual_value, $time);
            compare_outputs = error_count;
        end else begin
            $display("**FAIL**: %s: Expected = %d, Actual = %d, Time = %t", 
                      signal_name, expected_value, actual_value, $time);
            compare_outputs = error_count + 1;
        end
    endfunction 
endmodule
