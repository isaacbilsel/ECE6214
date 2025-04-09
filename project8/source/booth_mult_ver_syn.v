`timescale 1ns / 1ps

module booth_mult_ver_syn(
    input wire clk,
    input wire rst_n,
    input wire signed [15:0] a,  // 16-bit input
    input wire signed [15:0] b,  // 16-bit input
    output reg signed [31:0] c,  // 32-bit output
    output reg ready
);

reg signed [31:0] a_reg;
reg signed [31:0] b_reg;
reg signed [31:0] partial;
reg signed [31:0] partial_next;

reg [4:0] counter;
reg [4:0] next_count;
reg [1:0] state;
reg [1:0] next_state;

reg previous;

parameter IDLE = 2'b00,
          LOAD = 2'b01,
          COMPUTE = 2'b10,
          DONE = 2'b11;

always @(posedge clk or negedge rst_n)
begin
    if (rst_n == 1'b0) begin
        c <= 32'h00000000;
        partial <= 32'h00000000;
        counter <= 5'b00000;
        state <= IDLE;
    end else begin
        c <= partial;
        counter <= next_count;
        state <= next_state;
        partial <= partial_next;
    end   
end

always @(*) begin
    next_state = state;
    next_count = counter;

    case (state)
        IDLE: begin
            b_reg = (b[15] == 1'b1) ? {16'hFFFF, b} : {16'h0000, b};  // Sign extend b
            a_reg = (a[15] == 1'b1) ? {16'hFFFF, a} : {16'h0000, a};  // Sign extend a
            partial_next = 32'h00000000; 
            next_state = COMPUTE;
            ready = 0;
            next_count = 5'd0;
            previous = 1'b0;
        end
        
        COMPUTE: begin
            if (b_reg[0] == previous) 
                partial_next = partial;
            else begin
                if (previous == 1'b1)
                    partial_next = partial + a_reg;
                else
                    partial_next = partial - a_reg;  
            end   
            next_state = LOAD;
        end
        
        LOAD: begin
            b_reg = {partial[0], c[31:1]};
            partial_next = {1'b0, partial[31:1]};
            previous = c[0];
            next_count = counter + 1'b1;
            next_state = DONE;   
        end
        
        DONE: begin
            if (counter <= 5'b11111) begin
                next_state = COMPUTE;
            end else begin
                next_state = IDLE;
                ready = 1;
            end
        end
        
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
