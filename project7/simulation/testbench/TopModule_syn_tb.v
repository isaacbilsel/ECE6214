`timescale 1ns / 1ps

module TopModule_tb;

    // Testbench Signals
    reg clk;
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

    // Clock generation: 100 MHz (10 ns period)
    always #5 clk = ~clk;

    // initial block for SDF back annotation
    initial begin
      $sdf_annotate("../../synthesis/netlists/program_counter_syn.sdf",program_counter_syn_tb.DUT, ,"back_annotate.log");
    end

    // Testbench Variables
    reg [8*39:0] testcase;
    integer i;

    // Testbench Procedure
    initial begin
        testcase = "Initializing";
        clk          = 0;
        rst_n        = 0;
        data_in      = 4'd0;
        coeff_write  = 1'b0;
        coeff_addr   = 7'd0;
        coeff_in     = 8'd0;
        sample_rate  = 4'd13;
        new_symbol   = 1'b0;

        $display("Starting test: %s", testcase);

        // Reset sequence
        repeat(2) @(posedge clk);
        rst_n = 1;
        repeat(2) @(posedge clk);

        // Load FIR coefficients
        testcase = "Coefficient Load";
        $display("Starting test: %s", testcase);
        for (i = 0; i <= 70; i = i + 1) begin
            coeff_write = 1'b1;
            coeff_addr  = i[6:0];
            coeff_in    = i[7:0];
            @(negedge clk);
        end
        coeff_write = 1'b0;

        // Flush the pipeline
        repeat(10) @(posedge clk);

        // Impulse Response Test
        testcase = "Impulse";
        $display("Starting test: %s", testcase);
        @(negedge clk);
        data_in = 4'h1;
        new_symbol = 1'b1;
        repeat(2) @(negedge clk);
        data_in = 4'h0;
        new_symbol = 1'b0;
        @(negedge clk);
        repeat(150) @(posedge clk);

        // Step Response Test
        testcase = "Step";
        $display("Starting test: %s", testcase);
        data_in = 4'h1;
        new_symbol = 1'b1;
        repeat(150) @(posedge clk);

        // Pipeline Flush
        data_in = 4'h0;
        new_symbol = 1'b0;
        repeat(150) @(posedge clk);

        $display("Testbench complete.");
        $finish;
    end

    // Display outputs every clock cycle
    always @(posedge clk) begin
        $display("Time: %0t | Data Out: %0d | Data Out Valid: %0b", $time, data_out, data_out_valid);
    end

endmodule
