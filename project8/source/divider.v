module TopModule(
    input clk,
    // input upsample_clk,
    input rst_n,
    input wire [3:0] sample_rate,
    input [3:0] data_in,     	// 4-bit input data from the symbol generator.
    input coeff_write,
    input [7:0] coeff_in, 		// We may need to make this a two dimensional array
    input [6:0] coeff_addr,
    input wire new_symbol, 		
    output wire [11:0] data_out,  // 12-bit output data after FIR filtering.
    output reg data_out_valid    // Signal indicating when data_out contains valid data.
);
	
    // Internal signals
    wire [3:0] upsampler_out;
	wire [11:0] filter_out;
 
    // Time taken for filter to propagate output through and flush completely
	// Each filter has 4 CC latency, filters are pipelined, so
	// latency = 2 * (num_taps-1) + 4 = 144
    parameter LATENCY = 144;
    
    // Datapath reset variables
    reg [7:0] counter; // To count up to 256
    reg [7:0] counter_next;
    reg data_out_valid_next;
	
	// Upsampler Instatiantion
	upsampler u_upsampler(
		.clk(clk),
		.rst_n(rst_n),
		.sample_rate(sample_rate),
		.new_symbol(new_symbol),
		.input_data(data_in),
		.output_data(upsampler_out)
	);

    // FIR Filter instantiation
    fir_filter u_fir_filter(
        .clk(clk),
		.sample_in(upsampler_out),
        .coeff_write(coeff_write), 	//coeff_write_enable?
        .coeff_in(coeff_in),
        .coeff_addr(coeff_addr),
        .fir_out(filter_out)
    );
	
	// Logic for Datapath reset
	always @(posedge clk or posedge rst_n) begin
		if (!rst_n) begin
			counter <= 0;
			data_out_valid <= 0;
		end
		else begin
			counter <= counter_next;
			data_out_valid <= data_out_valid_next;
		end
	end
	
	always @(*) begin
		data_out_valid_next = data_out_valid;
		counter_next = counter;
		if(data_in) begin
			counter_next = counter + 1'b1;
		end
		if (counter < LATENCY) begin
			data_out_valid_next = 0;
		end
		else begin
			data_out_valid_next = 1'b1;
		end
	end
    
    assign data_out = filter_out;

endmodule


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

   


   
   


module coeff_memory(
		 input wire 		  clk,
		 input wire signed [7:0]  coeff_in,
		 input wire [6:0] 	  coeff_addr,
		 input wire 		  coeff_write,
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

   always @(posedge clk)
     begin
	if (coeff_write == 1'b1) begin
	   coeff_internal[coeff_addr] <= coeff_in;
	end
     end

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
   


module dsp_slice(
		 input wire clk,
		 input wire signed [3:0] sample_in,
		 input wire signed [11:0] accum_in,
		 input wire signed [7:0] coeff_in,
		 output wire signed [3:0] sample_out,
		 output wire signed [11:0] accum_out
		 );
    
    // internal signals
   reg signed [3:0] 			   sample_delay0;
   reg signed [3:0] 			   sample_delay1;
   reg signed [11:0] 			   mult_out;
   reg signed [11:0]                       accum;

   // assign outputs
   assign sample_out = sample_delay1;
   assign accum_out  = accum;
          
    // clock in registers   
    always @(posedge clk)
      begin
	 sample_delay0 <= sample_in;
	 sample_delay1 <= sample_delay0;
	 mult_out      <= sample_delay1 * coeff_in;
	 accum         <= accum_in + mult_out;         
    end
       
endmodule

module fir_filter(
		  input wire 		    clk,
		  input wire signed [3:0]   sample_in,
		  input wire 		    coeff_write,
		  input wire signed [7:0]   coeff_in,
		  input wire [6:0] 	    coeff_addr,
		  output wire signed [11:0] fir_out
		  );

   // internal signals
   wire signed [3:0] 				    sample_internal [0:71];
   wire signed [11:0] 				    accum_internal [0:71];
   wire signed [7:0] 				    coeff [0:70];
   
   // gernerate loop variables
   genvar 				    i;

   assign sample_internal[0] = sample_in;
   assign accum_internal[0] = 12'h000;
   assign fir_out = accum_internal[71];

   // generate statement to generate 71-tap FIR filter
   generate for (i = 0; i < 71; i = i + 1)
     begin: GEN_SLICE
	dsp_slice u_fir_slice(
			      .clk(clk),
			      .sample_in(sample_internal[i]),
			      .accum_in(accum_internal[i]),
			      .coeff_in(coeff[i]),
			      .sample_out(sample_internal[i+1]),
			      .accum_out(accum_internal[i+1])
			      );
     end
   endgenerate

   // filter coeff memory
   coeff_memory u_coeff_memory(
			       .clk(clk),
			       .coeff_in(coeff_in),
			       .coeff_addr(coeff_addr),
			       .coeff_write(coeff_write),
			       .coeff_out0(coeff[0]),
			       .coeff_out1(coeff[1]),
			       .coeff_out2(coeff[2]),
			       .coeff_out3(coeff[3]),
			       .coeff_out4(coeff[4]),
			       .coeff_out5(coeff[5]),
			       .coeff_out6(coeff[6]),
			       .coeff_out7(coeff[7]),
			       .coeff_out8(coeff[8]),
			       .coeff_out9(coeff[9]),
			       .coeff_out10(coeff[10]),
			       .coeff_out11(coeff[11]),
			       .coeff_out12(coeff[12]),
			       .coeff_out13(coeff[13]),
			       .coeff_out14(coeff[14]),
			       .coeff_out15(coeff[15]),
			       .coeff_out16(coeff[16]),
			       .coeff_out17(coeff[17]),
			       .coeff_out18(coeff[18]),
			       .coeff_out19(coeff[19]),
			       .coeff_out20(coeff[20]),
			       .coeff_out21(coeff[21]),
			       .coeff_out22(coeff[22]),
			       .coeff_out23(coeff[23]),
			       .coeff_out24(coeff[24]),
			       .coeff_out25(coeff[25]),
			       .coeff_out26(coeff[26]),
			       .coeff_out27(coeff[27]),
			       .coeff_out28(coeff[28]),
			       .coeff_out29(coeff[29]),
			       .coeff_out30(coeff[30]),
			       .coeff_out31(coeff[31]),
			       .coeff_out32(coeff[32]),
			       .coeff_out33(coeff[33]),
			       .coeff_out34(coeff[34]),
			       .coeff_out35(coeff[35]),
			       .coeff_out36(coeff[36]),
			       .coeff_out37(coeff[37]),
			       .coeff_out38(coeff[38]),
			       .coeff_out39(coeff[39]),
			       .coeff_out40(coeff[40]),
			       .coeff_out41(coeff[41]),
			       .coeff_out42(coeff[42]),
			       .coeff_out43(coeff[43]),
			       .coeff_out44(coeff[44]),
			       .coeff_out45(coeff[45]),
			       .coeff_out46(coeff[46]),
			       .coeff_out47(coeff[47]),
			       .coeff_out48(coeff[48]),
			       .coeff_out49(coeff[49]),
			       .coeff_out50(coeff[50]),
			       .coeff_out51(coeff[51]),
			       .coeff_out52(coeff[52]),
			       .coeff_out53(coeff[53]),
			       .coeff_out54(coeff[54]),
			       .coeff_out55(coeff[55]),
			       .coeff_out56(coeff[56]),
			       .coeff_out57(coeff[57]),
			       .coeff_out58(coeff[58]),
			       .coeff_out59(coeff[59]),
			       .coeff_out60(coeff[60]),
			       .coeff_out61(coeff[61]),
			       .coeff_out62(coeff[62]),
			       .coeff_out63(coeff[63]),
			       .coeff_out64(coeff[64]),
			       .coeff_out65(coeff[65]),
			       .coeff_out66(coeff[66]),
			       .coeff_out67(coeff[67]),
			       .coeff_out68(coeff[68]),
			       .coeff_out69(coeff[69]),
			       .coeff_out70(coeff[70])
			       );
   
endmodule
