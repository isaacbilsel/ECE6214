`timescale 1ns / 1ps

module sync_fifo_write_counter_tb(
    );
    
   reg        clk = 1'b1;
   reg	      rst_n = 1'b0;
   reg	      write_enable = 1'b0;	    
   reg  [3:0] read_pointer_gray;
   wire	      full;
   wire	      write_enable_out;
   wire [2:0] write_pointer;
   wire [3:0] write_pointer_gray;

   // testbench signals
   reg	[3:0] read_pointer = 4'h0;
   reg  [3:0] write_pointer_expected = 4'h0;
   reg  [3:0] write_pointer_expected_3bit = 4'h0;
   reg  [3:0] write_pointer_gray_expected;
   reg	      full_expected = 1'b0;
    
   sync_fifo_write_counter DUT(
	    .clk(clk),
	    .rst_n(rst_n),
	    .write_enable(write_enable),
	    .read_pointer_gray(read_pointer_gray),
	    .full(full),
	    .write_enable_out(write_enable_out),
	    .write_pointer(write_pointer),
	    .write_pointer_gray(write_pointer_gray)
	    );

   // write clock with 10ns period
    always #5 clk = ~clk;

   // convert read pointer to gray code
   always @(*) read_pointer_gray = read_pointer[3:0] ^ {1'b0, read_pointer[3:1]};

   // convert expected write pointer to gray code
   always @(*) write_pointer_gray_expected = write_pointer_expected[3:0] ^ {1'b0, write_pointer_expected[3:1]}; 
 
   // expected 3bit pinter to reg array
   always @(*) write_pointer_expected_3bit = write_pointer_expected[2:0];
  
    initial begin
       repeat(10)
	 @(posedge clk);

       rst_n = 1'b1;

       repeat(10)
	 @(posedge clk);
       
       //write pointer test
       repeat(8) begin
	  @(posedge clk)
	    write_enable = 1'b1;
	  @(posedge clk)
	    write_pointer_expected = write_pointer_expected + 1;
	    write_enable = 1'b0;
       end

       full_expected = 1'b1;

       //write pointer while full test
       repeat(8) begin
	  @(posedge clk)
	    write_enable = 1'b1;
	  @(posedge clk)
	    write_enable = 1'b0;
       end
       

       repeat(10)
	 @(posedge clk);

       // check full flag
       repeat(8) begin
	  @(posedge clk)
	    read_pointer = read_pointer + 1;
          @(posedge clk)
	    full_expected = 1'b0;
	    write_enable = 1'b1;
	  @(posedge clk)
	    full_expected = 1'b1;
	    write_pointer_expected = write_pointer_expected + 1;
	    write_enable = 1'b0;
       end
       
       
       #30
	 $finish;
    end
    
endmodule
