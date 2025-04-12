`timescale 1ns /1ps
///////////////////////////////
// ECE 6214
// Prof Matthew LaRue
// Memory for filter coefficients
///////////////////////////////

module coeff_memory(
	input wire 		  clk,
	input wire signed [7:0]  coeff_in,
	input wire [9:0] 	  coeff_addr,
	input wire 		  coeff_write,
	input wire 		  coeff_read,
	output wire signed [7:0] coeff_read_out,
	output wire signed [7:0] coeff_out0,
	output wire signed [7:0] coeff_out1,
	output wire signed [7:0] coeff_out2,
	output wire signed [7:0] coeff_out3,
	output wire signed [7:0] coeff_out4,
	output wire signed [7:0] coeff_out5,
	output wire signed [7:0] coeff_out6,
	output wire signed [7:0] coeff_out7,
	output wire signed [7:0] coeff_out8,
	output wire signed [7:0] coeff_out9,
	output wire signed [7:0] coeff_out10,
	output wire signed [7:0] coeff_out11,
	output wire signed [7:0] coeff_out12,
	output wire signed [7:0] coeff_out13,
	output wire signed [7:0] coeff_out14,
	output wire signed [7:0] coeff_out15,
	output wire signed [7:0] coeff_out16,
	output wire signed [7:0] coeff_out17,
	output wire signed [7:0] coeff_out18,
	output wire signed [7:0] coeff_out19,
	output wire signed [7:0] coeff_out20,
	output wire signed [7:0] coeff_out21,
	output wire signed [7:0] coeff_out22,
	output wire signed [7:0] coeff_out23,
	output wire signed [7:0] coeff_out24,
	output wire signed [7:0] coeff_out25,
	output wire signed [7:0] coeff_out26,
	output wire signed [7:0] coeff_out27,
	output wire signed [7:0] coeff_out28,
	output wire signed [7:0] coeff_out29,
	output wire signed [7:0] coeff_out30,
	output wire signed [7:0] coeff_out31,
	output wire signed [7:0] coeff_out32,
	output wire signed [7:0] coeff_out33,
	output wire signed [7:0] coeff_out34,
	output wire signed [7:0] coeff_out35,
	output wire signed [7:0] coeff_out36,
	output wire signed [7:0] coeff_out37,
	output wire signed [7:0] coeff_out38,
	output wire signed [7:0] coeff_out39,
	output wire signed [7:0] coeff_out40,
	output wire signed [7:0] coeff_out41,
	output wire signed [7:0] coeff_out42,
	output wire signed [7:0] coeff_out43,
	output wire signed [7:0] coeff_out44,
	output wire signed [7:0] coeff_out45,
	output wire signed [7:0] coeff_out46,
	output wire signed [7:0] coeff_out47,
	output wire signed [7:0] coeff_out48,
	output wire signed [7:0] coeff_out49,
	output wire signed [7:0] coeff_out50,
	output wire signed [7:0] coeff_out51,
	output wire signed [7:0] coeff_out52,
	output wire signed [7:0] coeff_out53,
	output wire signed [7:0] coeff_out54,
	output wire signed [7:0] coeff_out55,
	output wire signed [7:0] coeff_out56,
	output wire signed [7:0] coeff_out57,
	output wire signed [7:0] coeff_out58,
	output wire signed [7:0] coeff_out59,
	output wire signed [7:0] coeff_out60,
	output wire signed [7:0] coeff_out61,
	output wire signed [7:0] coeff_out62,
	output wire signed [7:0] coeff_out63,
	output wire signed [7:0] coeff_out64,
	output wire signed [7:0] coeff_out65,
	output wire signed [7:0] coeff_out66,
	output wire signed [7:0] coeff_out67,
	output wire signed [7:0] coeff_out68,
	output wire signed [7:0] coeff_out69,
	output wire signed [7:0] coeff_out70
);

    // internal signals
    reg signed [7:0] coeff_internal[0:70];
	reg signed [7:0] coeff_read_out_q;
	always @(posedge clk)
		begin
			// Handle coefficient writes
			if (coeff_write == 1'b1) begin
				coeff_internal[coeff_addr] <= coeff_in;
			end

			// Handle coefficient read requests
			else if (coeff_read == 1'b1) begin
				coeff_read_out_q <= coeff_internal[coeff_addr];
			end
			else if (coeff_read == 1'b0) begin
				coeff_read_out_q <= 1'b0;
			end
		end

	assign coeff_read_out = coeff_read_out_q;

	assign coeff_out0 = coeff_internal[0];
	assign coeff_out1 = coeff_internal[1];
	assign coeff_out2 = coeff_internal[2];
	assign coeff_out3 = coeff_internal[3];
	assign coeff_out4 = coeff_internal[4];
	assign coeff_out5 = coeff_internal[5];
	assign coeff_out6 = coeff_internal[6];
	assign coeff_out7 = coeff_internal[7];
	assign coeff_out8 = coeff_internal[8];
	assign coeff_out9 = coeff_internal[9];
	
	assign coeff_out10 = coeff_internal[10];
	assign coeff_out11 = coeff_internal[11];
	assign coeff_out12 = coeff_internal[12];
	assign coeff_out13 = coeff_internal[13];
	assign coeff_out14 = coeff_internal[14];
	assign coeff_out15 = coeff_internal[15];
	assign coeff_out16 = coeff_internal[16];
	assign coeff_out17 = coeff_internal[17];
	assign coeff_out18 = coeff_internal[18];
	assign coeff_out19 = coeff_internal[19];
	
	assign coeff_out20 = coeff_internal[20];
	assign coeff_out21 = coeff_internal[21];
	assign coeff_out22 = coeff_internal[22];
	assign coeff_out23 = coeff_internal[23];
	assign coeff_out24 = coeff_internal[24];
	assign coeff_out25 = coeff_internal[25];
	assign coeff_out26 = coeff_internal[26];
	assign coeff_out27 = coeff_internal[27];
	assign coeff_out28 = coeff_internal[28];
	assign coeff_out29 = coeff_internal[29];
	
	assign coeff_out30 = coeff_internal[30];
	assign coeff_out31 = coeff_internal[31];
	assign coeff_out32 = coeff_internal[32];
	assign coeff_out33 = coeff_internal[33];
	assign coeff_out34 = coeff_internal[34];
	assign coeff_out35 = coeff_internal[35];
	assign coeff_out36 = coeff_internal[36];
	assign coeff_out37 = coeff_internal[37];
	assign coeff_out38 = coeff_internal[38];
	assign coeff_out39 = coeff_internal[39];
	
	assign coeff_out40 = coeff_internal[40];
	assign coeff_out41 = coeff_internal[41];
	assign coeff_out42 = coeff_internal[42];
	assign coeff_out43 = coeff_internal[43];
	assign coeff_out44 = coeff_internal[44];
	assign coeff_out45 = coeff_internal[45];
	assign coeff_out46 = coeff_internal[46];
	assign coeff_out47 = coeff_internal[47];
	assign coeff_out48 = coeff_internal[48];
	assign coeff_out49 = coeff_internal[49];

	assign coeff_out50 = coeff_internal[50];
	assign coeff_out51 = coeff_internal[51];
	assign coeff_out52 = coeff_internal[52];
	assign coeff_out53 = coeff_internal[53];
	assign coeff_out54 = coeff_internal[54];
	assign coeff_out55 = coeff_internal[55];
	assign coeff_out56 = coeff_internal[56];
	assign coeff_out57 = coeff_internal[57];
	assign coeff_out58 = coeff_internal[58];
	assign coeff_out59 = coeff_internal[59];

	assign coeff_out60 = coeff_internal[60];
	assign coeff_out61 = coeff_internal[61];
	assign coeff_out62 = coeff_internal[62];
	assign coeff_out63 = coeff_internal[63];
	assign coeff_out64 = coeff_internal[64];
	assign coeff_out65 = coeff_internal[65];
	assign coeff_out66 = coeff_internal[66];
	assign coeff_out67 = coeff_internal[67];
	assign coeff_out68 = coeff_internal[68];
	assign coeff_out69 = coeff_internal[69];
	
	assign coeff_out70 = coeff_internal[70];
   
   
endmodule
   
