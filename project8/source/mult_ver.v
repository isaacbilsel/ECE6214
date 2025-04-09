module mult_ver(
    input wire clk,
    input wire rst_n,
    input wire signed [15:0] a,
    input wire signed [15:0] b,		       
    output reg signed [31:0] c
    );
   
always @(posedge clk or negedge rst_n)
     begin
        if (rst_n == 1'b0) begin
	   c <= 32'd00;
        end else begin
	   c <= a * b;
        end   
     end
   
endmodule
