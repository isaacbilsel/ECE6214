`timescale 10ns/10ps

module pipe_div(
	input wire clk,
	input wire rst_n,
	input wire signed [15:0] dividend,
	input wire signed [7:0] divisor,
	output reg signed [15:0] quotient,
	output reg signed [7:0] remainder,
	output reg ready,
	output reg error
	);

	// Input/output registers
	reg signed [15:0] dividend_q;
	reg signed [7:0] divisor_q;
	reg signed [15:0] quotient_next;
	reg signed [7:0] remainder_next;
	reg ready_next;
	
	// Helper variables
	reg [23:0] sreg;
	reg [23:0] sreg_next;
	reg en;
	reg en_next;
	reg [4:0] counter;
	reg [4:0] counter_next;
	reg [1:0] state;
	reg [1:0] next_state;
	reg signed [15:0] dividend_p;
	reg signed [7:0] divisor_p;
	reg signed [7:0] divisor_p_next;
	reg negate_quotient;
	reg negate_quotient_next;
	reg negate_remainder;
	reg negate_remainder_next;
	reg error_next;
	
	parameter   IDLE    = 2'b00, 
				COMPUTE = 2'b01, 
				OUTPUT  = 2'b10;
				
	// Sequential logic
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			dividend_q 	<= 0;
			divisor_q 	<= 0;
			sreg 		<= 0; 
			en 			<= 0;
			counter 	<= 0;
			state 		<= IDLE;
			dividend_p 	<= 0;
			// divisor_p	<= 0;
			ready 		<= 0;
			quotient 	<= 0;
			remainder 	<= 0;
			error		<= 0;
		end
		else begin
			dividend_q 	<= dividend;
			divisor_q 	<= divisor;
			quotient 	<= quotient_next;
			remainder 	<= remainder_next;
			en 			<= en_next;
			counter 	<= counter_next;
			state 		<= next_state;
			sreg		<= sreg_next;
			ready		<= ready_next;
			divisor_p 	<= divisor_p_next;
			error 		<= error_next;
			negate_quotient  <= negate_quotient_next;
			negate_remainder <= negate_remainder_next;
		end
	end
	
	// Combinational logic
	always @(*) begin
		error_next = error;
		ready_next = ready;
		quotient_next = quotient;
		remainder_next = remainder;
		sreg_next = sreg;
		en_next = en;
		counter_next = counter + 1;
		negate_quotient_next = negate_quotient;
		negate_remainder_next = negate_remainder;
		divisor_p_next = divisor_p;
		
		case (state)
			IDLE: begin
				// Check for inputs
				if ((divisor_q == 0) && (dividend_q == 0)) 
					next_state = IDLE;
					
				// Check for division by 0
				else if (divisor_q == 0) begin
					// Throw error flag
					error_next = 1'b1;
					next_state = IDLE;
				end
				
				// Prepare regs for computation
				else begin
					// Determine output signs
					negate_quotient_next = dividend_q[15] ^ divisor_q[7];
					negate_remainder_next = dividend_q[15];
					
					// Convert inputs to positive
					if (dividend_q[15]) dividend_p = -dividend_q;
					else dividend_p = dividend_q;
					if (divisor_q[7]) divisor_p_next = -divisor_q;
					else divisor_p_next = divisor_q;
					
					counter_next = 0;
					sreg_next = {8'h00, dividend_p};
					if (sreg[23:15] >= divisor_p_next) en_next = 1'b1; 		// warning: signed to unsigned conversion
					else en_next = 1'b0;
					
					next_state = COMPUTE;
				end
			end
			
			COMPUTE: begin
				if (counter == 16) begin
					next_state = OUTPUT;
					counter_next = 0;
					
					// Prepare output registers
					quotient_next = sreg_next[15:0];		// warning: signed to unsigned conversion
					remainder_next = sreg_next[23:16];		// warning: signed to unsigned conversion
					
					// Convert signs back
					if (negate_quotient) quotient_next = -quotient_next;
					if (negate_remainder) remainder_next = -remainder_next;
					ready_next = 1'b1;
				end
				
				else begin
					// calculate partial result and next sreg
					// partial = en * (sreg[23:16] - divisor_p);
					if (en) sreg_next[23:15] = (sreg[23:15] - divisor_p);	// warning: signed to unsigned conversion
					
					// left shift in new bit
					sreg_next = (sreg_next << 1) + en;
					
					/*
					// shift left in new bit
					sreg_next = (sreg << 1) + en;
					
					// Calculate partial difference 
					if (en) sreg_next[23:16] = en * (sreg_next[23:16] - divisor_p);
					*/
					
					if (sreg_next[23:15] >= divisor_p) en_next = 1'b1;		// warning: signed to unsigned conversion
					else en_next = 1'b0;
					next_state = COMPUTE;
				end
			end
			
			OUTPUT: begin
				// Set ready bit
				ready_next = 1'b0; 
				next_state = IDLE;
			end
			
			default: next_state = IDLE;
		
		endcase
	end
	
endmodule


