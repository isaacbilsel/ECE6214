`timescale 1ns /1ps
///////////////////////////////
// ECE 6214
// Prof Matthew LaRue
// Memory for filter outputs
///////////////////////////////

module sample_storage(
	input wire  clk,
    input wire  rst_n,     
	input wire signed [11:0]  sample_in,
	input wire [9:0] 	    sample_addr,
	input wire 		  sample_read,
    input wire         counter_begin,   // Signal to start writing to sample storage. Might need to register this?
	output wire signed [7:0] sample_read_out
);

    // Internal signals
    reg signed [7:0] sample_internal[0:127];
    reg signed [7:0] sample_internal_next[0:127];
	reg signed [7:0] sample_read_out_q;
	reg signed [7:0] msb_next;
    reg signed [7:0] lsb_next;
    reg signed [11:0] sample_q;
    reg [6:0] addr_next;
    
    // Simple FSM Variables
    parameter IDLE = 2'b00;
    parameter WRITE = 2'b01;
    parameter DONE = 2'b10;
    reg [1:0] state;
    reg [1:0] state_next; 
    reg [5:0] counter;
    reg [5:0] counter_next;

    integer i;

    // Sequential Logic
	always @(posedge clk) begin
        if (!rst_n) begin
            state <= IDLE;
            counter <= 6'd0;
            // Flush internal memory
            for (i=0; i<128; i=i+1) begin
                sample_internal[i] <= 8'h00;
            end
        end

        else begin
            counter <= counter_next;
            state <= state_next;
            sample_q <= sample_in;

            // Handle filter output writes (only filter can write). Only write first 64 samples
            if (counter_begin && (state==WRITE || state==IDLE)) begin
            	for (i=0; i<128; i=i+1) begin 		// Dont need to update whole array here. need to find lightweight solution
            	    sample_internal[i] <= sample_internal_next[i];
            	end
                // sample_internal[(counter-1) * 2] <= msb_next;           // 8 MSBs 
                // sample_internal[(counter-1) * 2 + 1] <= lsb_next; 		// 4 LSBs in addr + 1
            end

            // Handle coefficient read requests. We can only read 8 bits at a time, so only half of a filter output
            if (sample_read == 1'b1) begin
                sample_read_out_q <= sample_internal[sample_addr];
            end
            else if (sample_read == 1'b0) begin
                sample_read_out_q <= 1'b0;
            end
        end
    end

    // Combinational Logic FSM
    always @(*) begin
		for (i=0; i<128; i=i+1) sample_internal_next[i] = sample_internal[i];
        counter_next = counter;   
        state_next = state;
        msb_next = sample_q[11:4];
		lsb_next = {8'h0, sample_q[3:0]};
		addr_next = (counter-2) * 2;

		sample_internal_next[addr_next] = msb_next;
		sample_internal_next[addr_next+1] = lsb_next;
		
        case(state)
            IDLE: begin
                if (counter_begin) begin
                    state_next = WRITE;
                    counter_next = 1'b1;
                end
                else begin
                    state_next = IDLE;
                    counter_next = 6'd0;
                end
            end
            WRITE: begin
                if (counter < 63) begin
                    state_next = WRITE;
                    counter_next = counter + 1'b1;
                end
                else begin      // Sample storage is full
                    state_next = DONE; 
                    // counter_next <= 6'd0;
                end
            end
            DONE: begin         // Sample storage is full. Do nothing
                state_next = DONE; 
                // counter_next <= 6'd0;
            end
        endcase
    end

	assign sample_read_out = sample_read_out_q;
endmodule
   
