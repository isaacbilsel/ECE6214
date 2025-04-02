`timescale 1ns / 1ps

module TopModule_tb;
    
    // Testbench Signals
    reg clk;
    reg rst_n;
    reg [3:0] data_in;
    reg data_valid;
    reg coeff_write_enable;
    reg [6:0] coeff_addr;
    reg [7:0] coeff_data;
    wire [11:0] data_out;
    wire data_out_valid;
    
    // Instantiate the DUT (Device Under Test)
    TopModule dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .data_valid(data_valid),
        .coeff_write_enable(coeff_write_enable),
        .coeff_addr(coeff_addr),
        .coeff_data(coeff_data),
        .data_out(data_out),
        .data_out_valid(data_out_valid)
    );
    
    // Clock Generation
    always #5 clk = ~clk; // 10ns clock period
    
    // Testbench Procedure
    initial begin
        // Initialize Signals
        clk = 0;
        rst_n = 0;
        data_in = 0;
        data_valid = 0;
        coeff_write_enable = 0;
        coeff_addr = 0;
        coeff_data = 0;
        
        // Reset Pulse
        #20 rst_n = 1;
        
        // Load Coefficients
        #10 coeff_write_enable = 1;
        coeff_addr = 7'd0;
        coeff_data = 8'd5;
        #10 coeff_write_enable = 0;
        
        #10 coeff_write_enable = 1;
        coeff_addr = 7'd1;
        coeff_data = 8'd10;
        #10 coeff_write_enable = 0;
        
        // Apply Input Data
        #20 data_in = 4'b0011;
        data_valid = 1;
        #10 data_valid = 0;
        
        #20 data_in = 4'b0101;
        data_valid = 1;
        #10 data_valid = 0;
        
        // Wait for Output Processing
        #1000;
        
        // Finish Simulation
        $stop;
    end
    
endmodule
