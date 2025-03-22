`timescale 10ns / 10ps

module final_round(in,key,out);
  
  input [127:0]in, key;
  
  output [127:0] out;
  
  wire [127:0] A,B,C;
    
  S_128bit_S_box S_Box (
                        .in(in), 
                        .out(A)
                      );

  S_Shift_Rows Shift_row (
                          .S_Box_out(A), 
                          .Shift_Rows(B)
                        );
  
  // Add round key
  assign out = B^key;

 endmodule
