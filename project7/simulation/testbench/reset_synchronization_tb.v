
`timescale 1ns / 1ps

module reset_synchronization_tb;

  // Inputs
  reg clk;
  reg rst_n;

  // Output
  wire rst_n_sync;

  // Instantiate the Unit Under Test (UUT)
  reset_synchronization uut (
    .clk(clk),
    .rst_n(rst_n),
    .rst_n_sync(rst_n_sync)
  );

  // Clock generation: 10ns period = 100 MHz
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset sequence and test logic
  initial begin
    // Initial reset state
    rst_n = 0;

    // Hold reset low for a few cycles
    #20;

    // Deassert reset (go high)
    rst_n = 1;

    // Wait to see synchronization take effect
    #100;

    // Reassert reset to test behavior again
    rst_n = 0;
    #20;
    rst_n = 1;

    // Wait again
    #100;

    $finish;
  end

  // Display output changes
  initial begin
    $monitor("Time: %0t | rst_n: %b | rst_n_sync: %b", $time, rst_n, rst_n_sync);
  end

endmodule
