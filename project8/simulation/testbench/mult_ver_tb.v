module mult_ver_tb();
  reg clk=1;
  reg rst_n;
  reg [15:0] a;
  reg [15:0] b;
  wire [31:0] c;
  
  mult_ver DUT(.a(a),.b(b),.c(c),.clk(clk),.rst_n(rst_n));
  
  always #5 clk=~clk;
  initial 
    begin
      //rst_n=0;
      //#10;
      rst_n=1;
      a=15'd5;
      b=15'd5;
      #10;
      rst_n=1;
      a=15'd2;
      b=15'd5;
      #10;
    end
endmodule
