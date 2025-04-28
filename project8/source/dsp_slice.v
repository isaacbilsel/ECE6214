`timescale 1ns /1ps
///////////////////////////////
// ECE 6214
// Prof Matthew LaRue
// DSP Slice for FIR Filter
///////////////////////////////

module dsp_slice(
  input wire clk,
  input wire signed [3:0] sample_in,
  input wire signed [11:0] accum_in,
  input wire signed [7:0] coeff_in,
  output wire signed [3:0] sample_out,
  output wire signed [11:0] accum_out
);

  // internal signals
  reg signed [3:0] 			   sample_delay0;
  reg signed [3:0] 			   sample_delay1;
  reg signed [11:0] 			 mult_out;
  reg signed [11:0]        mult_out_q;
  reg signed [11:0]        accum;
  reg signed [11:0]        accum_q;

  // assign outputs
  assign sample_out = sample_delay1;
  assign accum_out  = accum_q;
        
  // Combinational logic   
  always @(posedge clk)
    begin
      sample_delay0 <= sample_in;
      sample_delay1 <= sample_delay0;
      mult_out_q    <= mult_out;
      accum_q       <= accum; 

  // Sequential logic
  end
  always @(*) begin
    mult_out = sample_delay1 * coeff_in;
    accum = accum_in + mult_out_q

  end
endmodule
