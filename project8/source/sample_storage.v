`timescale 1ns /1ps
///////////////////////////////
// ECE 6214
// Prof Matthew LaRue
// Memory for filter outputs
///////////////////////////////

module sample_storage(
	input wire  clk,
    input wire  rst_n,        // ?
	input wire signed [11:0]  sample_in,
	input wire [9:0] 	    sample_addr,
	// input wire 		  sample_write,
	input wire 		  sample_read,
    input wire         counter_begin,   // Signal to start writing to sample storage
	output wire signed [7:0] sample_read_out
);

    // Internal signals
    reg signed [7:0] sample_internal[0:127];
	reg signed [7:0] sample_read_out_q;
    
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

            // Handle filter output writes (only filter can write). Only write first 64 samples
            if (state == WRITE) begin
                sample_internal[counter * 2] <= sample_in[11:4];            // 8 MSBs 
                sample_internal[counter * 2 + 1] <= {8'h0, sample_in[3:0]}; // 4 LSBs in addr + 1
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
        counter_next <= counter;
        state_next <= state;
        case(state)
            IDLE: begin
                if (counter_begin) begin
                    state_next <= WRITE;
                    counter_next <= 1'b0;
                end
                else begin
                    state_next <= IDLE;
                    counter_next <= 6'd0;
                end
            end
            WRITE: begin
                if (counter < 64) begin
                    state_next <= WRITE;
                    counter_next <= counter + 1'b1;
                end
                else begin      // Sample storage is full
                    state_next <= DONE; 
                    counter_next <= 6'd0;
                end
            end
            DONE: begin         // Sample storage is full. Do nothing
                state_next <= DONE; 
                counter_next <= 6'd0;
            end
        endcase
    end

	assign sample_read_out = sample_read_out_q;
endmodule
   
