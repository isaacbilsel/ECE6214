`timescale 1ns / 1ps

module fir_filter_tb(
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


   // Clock generation (40 to 130 MHz -> ~7.7 ns period)
   // always #3.85 clk = ~clk;
   always #5 clk = ~clk;

   initial begin
      testcase = "Initializing";

      repeat(10)
	@(posedge clk);
	     

      // generate data to write into coeff memory
      for (i=0; i <=70; i = i+1) begin
	 coeff_write = 1'b1;
         coeff_addr  = i;
         coeff_in    = i;
	 @(negedge clk);	 
      end
	
      coeff_write = 1'b0;

      // flush the pipeline
      repeat(150)
	@(posedge clk);


      // simulate filter impulse response  
      testcase = "Impulse";
      @(negedge clk);
      sample_in = 4'h1;
      @(negedge clk);
      sample_in = 4'h0;
      @(negedge clk);
      repeat(150)
	@(posedge clk);
      @(negedge clk);

      // simulate filter step response
      testcase = "Step";
      sample_in = 4'h1;
      repeat(150)
	@(posedge clk);

      // flush the pipeline
      sample_in = 4'h0;
      repeat(150)
	@(posedge clk);
	// filter takes 112 clock cycles

      // simulate filter negativeimpulse response  
      testcase = "Neg_Impulse";
      @(negedge clk);
      sample_in = 4'hF;
      @(negedge clk);
      sample_in = 4'h0;
      @(negedge clk);
      repeat(150)
	@(posedge clk);
      @(negedge clk);

      // simulate filter negative step response
      testcase = "Neg_Step";
      sample_in = 4'hF;
      repeat(150)
	@(posedge clk);


      repeat(1000)
	@(posedge clk);

      $finish;
      
   end // initial begin
// Display output values at each clock edge
   always @(posedge clk) begin
      $display("Time: %0t | Testcase: %s | Sample In: %0d | FIR Out: %0d",
               $time, testcase, sample_in, fir_out);
   end

endmodule // fir_filter_tb

      
      
      
   
   
   
