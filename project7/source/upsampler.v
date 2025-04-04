`timescale 1ns / 1ps

module upsampler(
		 input wire	  clk,
		 input wire	  rst_n,
		 input wire       new_symbol,
		 input wire [3:0] input_data,
		 input wire [3:0] sample_rate,
		 output reg [3:0] output_data
		 );
   
   // parameter SAMPLERATE = 10;

   //variables
   reg [3:0] output_data_next;
   reg [3:0] sample_count_next;
   reg	     state_next;
   

   reg [3:0] sample_count_current;
   reg	     state_current;
   reg [3:0] sample_rate_q;

   parameter S0_IDLE = 1'b0;
   parameter S1_SAMPLING = 1'b1;

   parameter ZERO_PAD = 4'b0000;
   
   always @(posedge clk or negedge rst_n)
     begin
	if(rst_n == 1'b0)begin
	   output_data <= 4'd0;
	   sample_count_current <= 4'd0;
	   state_current <= S0_IDLE;
	end else begin
	   sample_rate_q <= sample_rate;
	   output_data <= output_data_next;
	   sample_count_current <= sample_count_next;
	   state_current <= state_next;
	end
     end

   always @(*)
     begin
	output_data_next = output_data;
	state_next = state_current;
	sample_count_next = sample_count_current;

	case(state_current)
	  S0_IDLE: begin
	     if(new_symbol == 1'b1)begin
		state_next = S1_SAMPLING;
	     end
	  end

	  S1_SAMPLING: begin
	     sample_count_next = sample_count_current + 1'b1;
	     
	     if(sample_count_current == sample_rate_q-1)begin
		state_next = S0_IDLE;
		sample_count_next = 4'd0;		
	     end else if(sample_count_current == 4'd0)begin
		output_data_next = input_data;
	     end else begin
		output_data_next = ZERO_PAD;
	     end

	  end // case: S1_SAMPLING
	endcase // case (state_current)	
     end // always @ (*)

endmodule // upsampler

   


   
