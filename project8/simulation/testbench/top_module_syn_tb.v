`timescale 1ns / 1ps

module top_module_syn_tb;

    // Clock and reset
    reg clk = 1;
    reg rst_n;

    // Input signals
    reg signed [15:0] data_in;
    reg data_valid;

    // Output signals
    wire signed [31:0] data_out;
    wire data_out_valid;

    // Testbench variables
    reg [(20*8)-1:0] testcase;
    reg [31:0] error_count = 0;

    // Instantiate the top module
    top_module DUT (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .data_valid(data_valid),
        .data_out(data_out),
        .data_out_valid(data_out_valid)
    );

    // Clock generation (100 MHz)
    always #5 clk = ~clk;

    // SDF Annotation
    initial begin
        $sdf_annotate("../../synthesis/netlist/top_module.sdf", top_module_syn_tb.DUT, , "back_annotate.log");
    end

    // Stimulus
    initial begin
        $monitor("Testcase %s | Time = %t | In = %d | Valid = %b | Out = %d | Out Valid = %b", 
                 testcase, $time, data_in, data_valid, data_out, data_out_valid);

        // Reset sequence
        rst_n = 0;
        data_in = 0;
        data_valid = 0;
        testcase = "Reset";
        #20 rst_n = 1;

        // Testcase 1
        testcase = "Impulse_Input";
        @(posedge clk); data_in = 16'sd1000; data_valid = 1;
        @(posedge clk); data_in = 16'sd0; data_valid = 0;

        // Wait for filter output
        wait (data_out_valid);
        #1 error_count = compare_outputs(32'sd1000, data_out, "Impulse_Out", error_count);

        // Testcase 2
        testcase = "Step_Input";
        repeat (10) begin
            @(posedge clk); data_in = 16'sd500; data_valid = 1;
        end
        @(posedge clk); data_valid = 0;

        wait (data_out_valid);
        #1 $display("Step Output: %d", data_out); // Optional check

        // Final Result
        if (error_count == 0) begin
            $display("\n\n----------SIMULATION PASSED----------");
        end else begin
            $display("\n\n----------SIMULATION FAILED----------");
            $display("---------- %d ERRORS TOTAL----------\n\n", error_count);
        end

        $finish;
    end

    // Output comparison function
    function [31:0] compare_outputs (
        input [31:0] expected_value,
        input [31:0] actual_value,
        input [8*19:0] signal_name,
        input [31:0] error_count
    );
        if (expected_value === actual_value) begin
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
