`timescale 1ns / 1ps

module sync_fifo_reg_array_tb(
    );
    
   reg        clk_write = 1'b1;
   reg	      rst_n_write = 1'b0;	    
   reg  [7:0] write_data = 8'h00;
   reg  [2:0] write_addr = 3'b000;
   reg	      write_enable = 1'b0;
   reg	      clk_read = 1'b1;
   reg	      rst_n_read = 1'b0;
   reg [2:0]  read_addr = 3'b000;
   reg	      read_enable = 1'b0;
   reg [7:0]  read_data_expected = 8'h00;	      
   wire [7:0] read_data;

   // loop variables
   integer    i; 
    
   sync_fifo_reg_array DUT(
	    .clk_write(clk_write),
	    .rst_n_write(rst_n_write),
	    .write_data(write_data),
	    .write_addr(write_addr),
	    .write_enable(write_enable),
	    .clk_read(clk_read),
	    .rst_n_read(rst_n_read),
	    .read_addr(read_addr),
	    .read_enable(read_enable),
	    .read_data(read_data)
	    );

   // write clock with 10ns period
    always #5 clk_write = ~clk_write;

   // read clock with 17ns period
   always #8.5 clk_read = ~clk_read;
   
    
    initial begin
       repeat(10)
	 @(posedge clk_write);

       rst_n_write = 1'b1;
       rst_n_read  = 1'b1;

       repeat(10)
	 @(posedge clk_write);
       
       //write tests

       @(posedge clk_write)

       // write to register array
       for(i = 0; i <= 7; i = i+1) begin
	  @(posedge clk_write)
	    // enable write and write {address + 1} to each address
	  write_enable = 1'b1;
	  write_addr   = i;
	  write_data   = i+1;
	  
	  @(posedge clk_write)
	    // disable write and change write data to {address - 1} to ensure write
	    //    only happens when enabled
	  write_enable = 1'b0;
	  write_data   = i-1;
       end // for (i = 0; i <= 7; i = i+1)


       repeat(10)
	 @(posedge clk_read);
       
       // read data from register array
       for(i = 0; i <= 7; i = i+1) begin
	  @(posedge clk_read)
	  read_enable = 1'b1;
	  read_addr   = i;
	  
	  @(posedge clk_read)
	  read_enable        = 1'b0;
	  read_data_expected = i+1;
	  
       end // for (i = 0; i <= 7; i = i+1)


       
       #30
	 $finish;
    end
    
endmodule
