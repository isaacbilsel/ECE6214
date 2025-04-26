`timescale 1ns / 1ps


module symbol_mapping_tb(); 
  reg data_in;
  reg data_clk = 1'b0; 
  reg rst_n;
  wire new_symbol; 
  wire [3:0] I;
  wire [3:0] Q;

  integer i;

  // Clock Generation: 60 MHz (period = 16.66 ns)
  always #8.33 data_clk = ~data_clk;

// initial block for SDF back annotation
    initial begin
      $sdf_annotate("../../synthesis/netlists/symbol_mapping_syn.sdf",symbol_mapping_syn_tb.dut1, ,"back_annotate.log");
    end

  // Instantiate the DUT
  symbol_mapping dut1 (
    .data_in(data_in),
    .data_clk(data_clk),
    .rst_n(rst_n),
    .new_symbol(new_symbol),
    .I(I),
    .Q(Q)
  );

  initial begin
    // Dump waveforms
    $dumpfile("waveform.vcd");
    $dumpvars(0, symbol_mapping_tb);

    // Apply Reset
    rst_n = 0;
    data_in = 0;
    #100; // Extended reset duration
    rst_n = 1;

    // Header Bits (example pattern: 12 bits)
    data_in = 1; #20; // Bit 1
    data_in = 0; #20; // Bit 2
    data_in = 1; #20; // Bit 3
    data_in = 1; #20; // Bit 4
    data_in = 0; #20; // Bit 5
    data_in = 0; #20; // Bit 6
    data_in = 1; #20; // Bit 7
    data_in = 1; #20; // Bit 8
    data_in = 1; #20; // Bit 9
    data_in = 1; #20; // Bit 10
    data_in = 0; #20; // Bit 11
    data_in = 0; #20; // Bit 12

    // Random Data Stream (simulate many bits)
    for (i = 0; i < 3072; i = i + 1) begin
      data_in = $random % 2; // 0 or 1
      #20;
      $display("Data bit %0d: %b, I: %b, Q: %b, new_symbol: %b", i, data_in, I, Q, new_symbol); // Display each bit and corresponding I, Q values
    end

    // Finish simulation
    #100;
    $finish;
  end

 /* initial begin
  $dumpfile("waveform.vcd");
  $dumpvars(0,symbol_mapping_tb);
end */
endmodule
