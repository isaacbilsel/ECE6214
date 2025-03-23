`timescale 10ns / 10ps

module final_round(in,key,out);
  input [127:0]in, key;
  output [127:0] out;
  wire [127:0] A,B,C;
  
  // Sub bytes
  sub_bytes sub_final (
                        .in(in), 
                        .out(A)
                      );

  // Shift rows
  shift_rows shift_final (
                          .S_Box_out(A), 
                          .Shift_Rows(B)
                        );
  
  // Add round key
  assign out = B^key;

 endmodule
