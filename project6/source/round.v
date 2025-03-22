`timescale 10ns / 10ps

module round(text, key, out);
  
  input [127:0] text, key;
  output [127:0] out;
  
  wire [127:0] A,B,C;

  sub_bytes sub ( .in(Test), .out(A));

  shift_rows shift (.S_Box_out(A), .Shift_Rows(B));

  mix_cols mixcolumn (.in(B), .out(C));

  // Add round key
  assign out = C ^ key;

endmodule

