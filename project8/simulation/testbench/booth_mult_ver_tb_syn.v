`timescale 1ns / 1ps

module booth_mult_ver_tb_syn;
    // Testbench Signals
    reg clk;
    reg rst_n;
    reg [15:0] a;
    reg [15:0] b;
    wire [31:0] c;
    reg [(20*8)-1:0] testcase;
    reg [31:0] error_count = 32'h00000000;
    wire ready;

    // Instantiate the multiplier module
    booth_mult_ver_syn DUT (
        .a(a),
        .b(b),
        .c(c),
        .clk(clk),
        .rst_n(rst_n),
        .ready(ready)
    );

 // Clock Generation (100 MHz)
    always #5 clk = ~clk;

// initial block for SDF back annotation
   initial begin
      $sdf_annotate("../../synthesis/netlist/booth_mult_ver_syn_syn.sdf",booth_mult_ver_syn_tb.DUT, ,"back_annotate.log");
   end

  
    

    // Testbench Logic
    initial begin
        $monitor("Testcase %s | Time = %t | A = %d | B = %d | Product = %d | ready = %d", 
                 testcase, $time, a, b, c, ready);

        // Initialize signals
        clk = 1;
        rst_n = 1;
        a = 0;
        b = 0;
        testcase = "Reset_Check";

        // Apply Reset
        //#5 rst_n = 0;
        //#10 rst_n = 1;
        //#10 error_count = compare_outputs(8'h00, c, "Product", error_count);

        // Test 1
        testcase = "Test_1";
        a = 16'd7;
        b = 16'd4;
        #20 error_count = compare_outputs(32'h0000001C, c, "Product", error_count);
        #20 error_count = compare_outputs(1'b1, ready, "ready", error_count);
	

        // Test 2
        testcase = "Test_2";
        a = 16'd5 ;
        b = -16'd5;
        #20 error_count = compare_outputs(-32'd25, c, "Product", error_count);
        #20 error_count = compare_outputs(1'b1, ready, "ready", error_count);

        // Test 3
        testcase = "Test_3";
        a = -16'd7;
        b = 16'd1;
        #20 error_count = compare_outputs(-32'd7, c, "Product", error_count);
        #20 error_count = compare_outputs(1'b1, ready, "ready", error_count);
	

        // Test 4
        testcase = "Test_4";
        a = -16'd5 ;
        b = -16'd5;
        #20 error_count = compare_outputs(32'd25, c, "Product", error_count);
        #20 error_count = compare_outputs(1'b1, ready, "ready", error_count);

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
