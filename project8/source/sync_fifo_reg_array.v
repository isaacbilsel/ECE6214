`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ECE6213
// Matthew LaRue 
// CDC fifo reg array
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module sync_fifo_reg_array(
	    input wire	     clk_write,
	    input wire	     rst_n_write,
	    input wire signed [7:0] write_data,
	    input wire [2:0] write_addr,
	    input wire	     write_enable,
	    input wire	     clk_read,
	    input wire	     rst_n_read,
	    input wire [2:0] read_addr,
	    input wire	     read_enable,
	    output reg signed [7:0] read_data
    );

	// internal registers
	reg [7:0]		     fifo_data_current[7:0];

	// internal combinational variables
	reg [7:0]		     fifo_data_next[7:0];
	reg [7:0]		     read_data_next;

	// loop variables
	integer		     i;
	integer		     j;

	// write sequential logic, active-low asynch reset
	always @(posedge clk_write or negedge rst_n_write) begin
		if (rst_n_write == 1'b0) begin
			// reset all registers to default values
			for(i=0;i<=7;i=i+1) begin
				fifo_data_current[i] <= 8'h00;
			end
		end else begin
			for(i=0;i<=7;i=i+1) begin
				fifo_data_current[i] <= fifo_data_next[i];
			end
		end // else: !if(rst_n == 1'b0)
	end // always @ (posedge clk or negedge rst_n)

	// write combinational logic
	always @(*) begin
		// assign default values to all comb variables
		for(j=0;j<=7;j=j+1) begin
			fifo_data_next[j] = fifo_data_current[j];
		end

		// write logic
		if (write_enable == 1'b1) begin
			fifo_data_next[write_addr] = write_data;
		end	
	end // always @ (*)

	// read sequential logic
	always @(posedge clk_read or negedge rst_n_read) begin
		if (rst_n_read == 1'b0) begin
			// reset all registers to default values
			read_data <= 8'h00;
		end 
		else begin
			read_data <= read_data_next;
		end // else: !if(rst_n == 1'b0)
	end // always @ (posedge clk or negedge rst_n)

	// read combinational logic
	always @(*) begin
		// default to hold read data value
		read_data_next = read_data;

		// read logic
		if (read_enable == 1'b1) begin
			read_data_next = fifo_data_current[read_addr];
		end
	end 

endmodule
