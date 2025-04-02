`timescale 1ns / 1ps

module upsample_tb(
		   );

   reg clk = 1'b0;
   reg rst_n = 1'b0;
   reg new_symbol = 1'b0;
   reg [3:0] input_data = 4'b0000;
   wire [3:0] output_data;
   reg [3:0] input_test_data[0:4];
   reg [3:0] error_count;
   
   integer i;

   upsampler DUT(
		 .clk(clk),
		 .rst_n(rst_n),
		 .new_symbol(new_symbol),
		 .input_data(input_data),
		 .output_data(output_data)
		 );

   always #4.615 clk = ~clk;

   initial begin
      repeat(10)
	@(posedge clk);
      rst_n = 1'b1;
      
      //initialize test data
      for(i = 0; i <= 4; i = i +1)begin
	input_test_data[i] = $random;
      end 
      
      //testing input data without new symbol flag
      repeat(1)
	@(posedge clk);
      input_data = 4'hF;
      repeat(13)
	@(posedge clk);
      error_count = confirm_output(4'd0, output_data, error_count);
	
      for(i = 0; i <= 4; i = i + 1)begin
	repeat(1)
	  @(posedge clk);
	new_symbol = 1'b1;
	input_data = input_test_data[i];
	repeat(2)
	  @(posedge clk);
	error_count = confirm_output(input_test_data[i], output_data, error_count);
	repeat(11)
	  @(posedge clk);
	error_count = confirm_output(4'd0, output_data, error_count);
	new_symbol = 1'b0;
      end
      
      repeat(10)
	@(posedge clk);

      $finish;
   end // initial begin
   
   function [3:0] confirm_output(
				  input [3:0] expected_value,
				  input [3:0] actual_value,
				  input [3:0] error_count
				  );
				  
	  if(expected_value == actual_value)begin
	      $display("PASS, Expected = %b, Actual = %b, Time = %t", expected_value, actual_value, $time);
	      confirm_output = error_count;
	  end else begin
	      $display("FAIL**, Expected = %b, Actual = %b, Time = %t", expected_value, actual_value, $time);
	      confirm_output = error_count + 1'b1;
	  end
   endfunction

endmodule // upsample_tb


   
