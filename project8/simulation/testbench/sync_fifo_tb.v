`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ECE6213
// Matthew LaRue 
// CDC FIFO top-level testbench
// 
// 
//////////////////////////////////////////////////////////////////////////////////

module sync_fifo_tb(
    );

   // signal to/from DUT
   reg        clk_write = 1'b1;
   reg	      rst_n_write = 1'b0;
   reg        clk_read = 1'b1;
   reg	      rst_n_read = 1'b0;
   reg	      write_enable = 1'b0;
   reg	      read_enable = 1'b0;	    
   reg  [7:0] write_data = 8'h00;
   wire	      full;
   wire	      empty;
   wire [7:0] read_data;

   // testbench signals
   reg	      full_expected = 1'b0;
   reg	      empty_expected = 1'b0;
   reg [7:0]  test_data[0:32];

   // signals for simulation control	      
   reg [8*39:0]    testcase;
   integer	   i;
   reg [7:0]	   error_count = 8'h00;
    
   sync_fifo DUT(
	    .clk_write(clk_write),
	    .clk_read(clk_read),
	    .rst_n_write(rst_n_write),
	    .rst_n_read(rst_n_read),
	    .write_data(write_data),
	    .write_enable(write_enable),
	    .read_enable(read_enable),
	    .read_data(read_data),
	    .fifo_full(full),
	    .fifo_empty(empty)
	    );

   // write clock with 10ns period
   always #5 clk_write = ~clk_write;

   // read clock with 17ns period
   always #8.5 clk_read = ~clk_read;
  
    initial begin
       testcase = "Initializing";
       
       // generate data to write into fifo
       for(i = 0; i <=31; i = i+1) begin
	  test_data[i] = $random;
       end
       
       repeat(10)
	 @(posedge clk_write);

       rst_n_write = 1'b1;
       rst_n_read  = 1'b1;

       full_expected = 1'b0;
       empty_expected = 1'b1;
       

       repeat(10)
	 @(posedge clk_write);

       testcase = "Write_tests";
       // write 8 pieces of data to fifo
       i = 0;
       repeat(8) begin
	  @(posedge clk_write)
	  write_enable = 1'b1;
	  write_data   = test_data[i];

	  // de-assert enable and change data to verify data isn't written when write isn't enabled
	  @(posedge clk_write)
	  empty_expected = 1'b0; 
	  write_enable = 1'b0;
	  write_data   = test_data[i+1];
	  i = i + 1;
       end

       @(posedge clk_write)
       full_expected = 1'b1;

       //try to write when fifo is full, shouldn't write
       repeat(3) begin
	  @(posedge clk_write)
	    write_enable = 1'b1;
	    write_data   = test_data[i];
	  @(posedge clk_write)
	    write_enable = 1'b0;
       end
       
       repeat(10)
	 @(posedge clk_read);

       testcase = "Readback_tests";
       i = 0;
       repeat(8) begin
	  @(posedge clk_read)
	  read_enable = 1'b1;
          @(posedge clk_read)
	  full_expected = 1'b0;
	  read_enable = 1'b0;
	  #1
	  error_count = compare_outputs(test_data[i],read_data,"read_data",error_count);
	  i = i +1;	  
       end

       empty_expected = 1'b1;
       


       testcase = "Alternating";
       i = 8;
       repeat(24) begin
	  // write data
	  @(posedge clk_write)
	  write_enable = 1'b1;
	  write_data   = test_data[i];

	  // de-assert write
	  @(posedge clk_write)
	  write_enable = 1'b0;

	  // wait a couple of read clocks 
          @(posedge clk_read)
	  @(posedge clk_read)	  
	  @(posedge clk_read)
	  empty_expected = 1'b0;
	  read_enable = 1'b1;
	  @(posedge clk_read)
	  empty_expected = 1'b1;
	  read_enable = 1'b0;
	  #1
	  error_count = compare_outputs(test_data[i],read_data,"read_data",error_count);
	  i = i +1;	  
       end // repeat (24)

       // check final error count, should be 0
       error_count = compare_outputs(0,error_count,"**ERROR_COUNT**",error_count);

      
       
       
       #30
	 $finish;
   end // initial begin


   function reg [7:0] compare_outputs (
		input [7:0]    expected_value, 
                input [7:0]    actual_value,
		input [8*19:0] signal_name,
                input [7:0]    error_count);
      if ( expected_value == actual_value ) begin
	 $display("PASS:  %s: Expected = %b, Actual = %b, Time = %t", signal_name, expected_value, actual_value, $time);
	 compare_outputs = error_count;	 
      end else begin
	 $display("FAIL** %s: Expected = %b, Actual = %b, Time = %t", signal_name, expected_value, actual_value, $time);
	 compare_outputs = error_count + 1;
      end
   endfunction // compare_outputs	      
    
endmodule
