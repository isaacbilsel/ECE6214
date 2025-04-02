`timescale 1ns / 1ps
/////////////////////////
// ECE6214
// Professor Matthew LaRue
// FIR Filter Testbench
////////////////////////

module fir_filter_syn_tb(
		     );


   // signal to/from DUT
   reg                clk = 1'b1;
   reg  signed [3:0]  sample_in = 4'h0;
   reg 		      coeff_write = 1'b0;
   reg  signed [7:0]  coeff_in;
   reg  signed [6:0]  coeff_addr;
   wire signed [11:0] fir_out;

   // testbench signals
   reg [8*39:0]       testcase;
   integer 	      i;

   fir_filter DUT(
		  .clk(clk),
		  .sample_in(sample_in),
		  .coeff_write(coeff_write),
		  .coeff_in(coeff_in),
		  .coeff_addr(coeff_addr),
		  .fir_out(fir_out)
		  );

   initial begin
      $sdf_annotate("../../synthesis/netlists/fir_filter_syn.sdf",DUT,,"fir_filter_annotate.log");
      
   end

   // clock with 9s period
   always #4.5 clk = ~clk;

   initial begin
      testcase = "Initializing";

      repeat(10)
	@(negedge clk);
	     

      // generate data to write into coeff memory
      for (i=0; i <=70; i = i+1) begin
	 coeff_write = 1'b1;
         coeff_addr  = i;
         coeff_in    = i;
	 @(negedge clk);	 
      end
	
      coeff_write = 1'b0;

      // flush the pipeline
      repeat(100)
	@(negedge clk);


      // simulate filter impulse response  
      testcase = "Impulse";
      @(negedge clk);
      sample_in = 4'h1;
      @(negedge clk);
      sample_in = 4'h0;
      @(negedge clk);
      repeat(100)
	@(negedge clk);
      @(negedge clk);

      // simulate filter step response
      testcase = "Step";
      sample_in = 4'h1;
      repeat(100)
	@(negedge clk);

      // flush the pipeline
      sample_in = 4'h0;
      repeat(100)
	@(negedge clk);

      // simulate filter negativeimpulse response  
      testcase = "Neg_Impulse";
      @(negedge clk);
      sample_in = 4'hF;
      @(negedge clk);
      sample_in = 4'h0;
      @(negedge clk);
      repeat(100)
	@(negedge clk);
      @(negedge clk);

      // simulate filter negative step response
      testcase = "Neg_Step";
      sample_in = 4'hF;
      repeat(100)
	@(negedge clk);


      repeat(500)
	@(negedge clk);

      $finish;
      
   end // initial begin

endmodule // fir_filter_syn_tb

      
      
      
   
   
   
