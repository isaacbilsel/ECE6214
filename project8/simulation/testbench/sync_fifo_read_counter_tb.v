`timescale 1ns / 1ps

module sync_fifo_read_counter_tb(
    );
    
   reg        clk = 1'b1;
   reg	      rst_n = 1'b0;
   reg	      read_enable = 1'b0;	    
   reg  [3:0] write_pointer_gray;
   wire	      empty;
   wire	      read_enable_out;
   wire [2:0] read_pointer;
   wire [3:0] read_pointer_gray;

   // testbench signals
   reg	[3:0] write_pointer = 4'h0;
   reg  [3:0] read_pointer_expected = 4'h0;
   reg  [2:0] read_pointer_expected_3bit = 3'h0; 
   reg  [3:0] read_pointer_gray_expected;
   reg	      empty_expected = 1'b0;
    
   sync_fifo_read_counter DUT(
	    .clk(clk),
	    .rst_n(rst_n),
	    .read_enable(read_enable),
	    .write_pointer_gray(write_pointer_gray),
	    .empty(empty),
	    .read_enable_out(read_enable_out),
	    .read_pointer(read_pointer),
	    .read_pointer_gray(read_pointer_gray)
	    );

   // write clock with 10ns period
    always #5 clk = ~clk;

   // convert write pointer to gray code
   always @(*) write_pointer_gray = write_pointer[3:0] ^ {1'b0, write_pointer[3:1]};

   // convert expected read pointer to gray code
   always @(*) read_pointer_gray_expected = read_pointer_expected[3:0] ^ {1'b0, read_pointer_expected[3:1]};

   // expected 3bit pinter to reg array
   always @(*) read_pointer_expected_3bit = read_pointer_expected[2:0];
   
   
    initial begin
       repeat(10)
	 @(posedge clk);

       rst_n = 1'b1;
       empty_expected = 1'b1;

       repeat(10)
	 @(posedge clk);

       // check empty flag, then set write pointer to 7 and verify empty de-asserts
       write_pointer = 7;
       @(posedge clk);
       empty_expected = 1'b0;
           
       //read pointer test
       repeat(7) begin
	  @(posedge clk)
	    read_enable = 1'b1;
	  @(posedge clk)	    
	    read_pointer_expected = read_pointer_expected + 1;
	    read_enable = 1'b0;
       end

       empty_expected = 1'b1;
       
       //read pointer while empty test
       repeat(8) begin
	  @(posedge clk)
	    read_enable = 1'b1;
	  @(posedge clk)
	    read_enable = 1'b0;
       end

       write_pointer = 14;
       @(posedge clk);
       empty_expected = 1'b0;
           
       //read pointer test
       repeat(7) begin
	  @(posedge clk)
	    read_enable = 1'b1;
	  @(posedge clk)	    
	    read_pointer_expected = read_pointer_expected + 1;
	    read_enable = 1'b0;
       end

       empty_expected = 1'b1;
       
       repeat(10)
	 @(posedge clk);

       // check empty flag
       /*
       repeat(8) begin
	  @(posedge clk)
	    write_pointer = write_pointer + 1;
          @(posedge clk)
	    empty_expected = 1'b0;
	    read_enable = 1'b1;
	  @(posedge clk)
	    empty_expected = 1'b1;
	    read_pointer_expected = read_pointer_expected + 1;
	    read_enable = 1'b0;
       end
	*/
       
       
       #30
	 $finish;
    end
    
endmodule
