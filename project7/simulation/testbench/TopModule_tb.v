`timescale 1ns / 1ps

module TopModule_tb;
    
    // Testbench Signals
    reg clk;
    // reg upsample_clk;
    reg rst_n;
    reg [3:0] data_in;
    reg data_valid;
    reg coeff_write;
    reg [6:0] coeff_addr;
    reg [7:0] coeff_in;
    wire [11:0] data_out;
    wire data_out_valid;
     
    // Instantiate the DUT (Device Under Test)
    TopModule dut (
        .clk(clk),
	// .upsample_clk(upsample_clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .data_valid(data_valid),
        .coeff_write(coeff_write),
        .coeff_addr(coeff_addr),
        .coeff_in(coeff_in),
        .data_out(data_out),
        .data_out_valid(data_out_valid)
    );
    
    // Clock Generation
    // Clock frequency: 40MhZ - 130MHz
    // Clock Period: 25 ns -7.7 ns
    // always #5 upsample_clk = ~upsample_clk; // 10ns clock period
    always #5 clk = ~clk; 	// 100 ns clock

    // Testbench Procedure
    initial begin
        // Initialize Signals
        clk = 0;
        upsample_clk = 0;
	rst_n = 0;
        data_in = 0;
        data_valid = 0;
        coeff_write_enable = 0;
        coeff_addr = 0;
        coeff_data = 0;
        
        // Reset Pulse
        #200 rst_n = 1;
        
        // Load Coefficients
        #100 coeff_write_enable = 1;
        coeff_addr = 7'd0;
        coeff_data = 8'd5;
        #10 coeff_write_enable = 0;
        
        #100 coeff_write_enable = 1;
        coeff_addr = 7'd1;
        coeff_data = 8'd10;
        #100 coeff_write_enable = 0;
        
        // Apply Input Data
        #200 data_in = 4'b0011;
        data_valid = 1;
        #100 data_valid = 0;
        
        #200 data_in = 4'b0101;
        data_valid = 1;
        #100 data_valid = 0;
        
        // Wait for Output Processing
        #10000;
        
        // Finish Simulation
        $stop;
    end
    
endmodule
