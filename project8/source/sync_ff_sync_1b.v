`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ECE6213
// Matthew LaRue 
// CDC FIFO write counter
// 
// 
//////////////////////////////////////////////////////////////////////////////////

// 64-QAM Modulator 1-bit two flip flop synchronizer module

module sync_ff_sync_1b(
	    input wire	     clk,
	    input wire	     rst_n,
	    input wire       data_in,
	    output reg       data_out
    );

   // internal registers
   reg  		     data_mid;

   // write sequential logic, active-low asynch reset
   always @(posedge clk or negedge rst_n)
     begin
	if (rst_n == 1'b0) begin
	   // reset all registers to default values
	   data_out <= 1'b0;
	   data_mid <= 1'b0;
	end else begin
	   data_out <= data_mid;
	   data_mid <= data_in;
	end // else: !if(rst_n == 1'b0)
     end // always @ (posedge clk or negedge rst_n)

endmodule
