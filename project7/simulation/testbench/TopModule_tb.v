// TopModule_tb.v
`timescale 1ns / 1ps

module TopModule_tb();

    reg clk;
    reg rst_n;
    reg [3:0] data_in;
    reg data_valid;
    wire [11:0] data_out;
    wire data_out_valid;

    TopModule uut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .data_valid(data_valid),
        .data_out(data_out),
        .data_out_valid(data_out_valid)
    );

    initial clk = 0;
    always #5 clk = ~clk; // 100MHz clock

    initial begin
        rst_n = 1;
        data_in = 0;
        data_valid = 0;
        
        // Apply reset
        #40; // Keep reset high for several clock cycles
        rst_n = 0;
        #20; // Wait for any internal resets
        
        // Start inputting valid data
        data_valid = 1;
        data_in = 4'b0010; // Example input
        #10;
	data_valid = 1;
        //data_in = 4'b0101; // Next input
        // Continue with the test vectors as needed.

        // Optional: hold the simulation for a specific time
        #1000;
        
        // Finish the simulation
        $finish;
    end

    // Optional: Monitor and display output signals
    initial begin
        $monitor("Time = %t, reset = %b, data_in = %b, data_out = %h, data_out_valid = %b",
                 $time, rst_n, data_in, data_out, data_out_valid);
    end
endmodule
