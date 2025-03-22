module AES(clk,rst_n,plaintext_in,key_in,start_encryption,ciphertext_out, encryption_done);
  input clk,rst_n;
  input start_encryption;
  input [127:0]plaintext_in,key_in;
  output [127:0]ciphertext_out;
  output encryption_done;
  wire [127:0]Round2key1,Round2key2,Round2key3,Round2key4,Round2key5,Round2key6,Round2key7,Round2key8,Round2key9,Round2key10;
  wire [127:0]ciphertext_out;
  
 
	wire [127:0]A,B,C,D,E,F,G,H,I,J;
  
  add_round_key  Add_round (
                              .Data(Plain_Test), 
                              .key(Key), 
                              .out(A)
                              );
    
  round round1 (
                            .Test(A), 
                            .Key(Round2key1), 
                            .Code(B)
                            );
  
  round round2 (
                              .Test(B), 
                              .Key(Round2key2), 
                              .Code(C)
                            );
  
  round round3 (
                              .Test(C), 
                              .Key(Round2key3), 
                              .Code(D)
                            );
  
  round round4 (
                              .Test(D), 
                              .Key(Round2key4), 
                              .Code(E)
                            );
  
  round round5 (
                              .Test(E), 
                              .Key(Round2key5), 
                              .Code(F)
                            );
  
  round round6 (
                              .Test(F), 
                              .Key(Round2key6), 
                              .Code(G)
                            );
  
  round round7 (
                              .Test(G), 
                              .Key(Round2key7), 
                              .Code(H)
                            );
  round round8 (
                              .Test(H), 
                              .Key(Round2key8), 
                              .Code(I)
                            );
  
  round round9 (
                              .Test(I), 
                              .Key(Round2key9), 
                              .Code(J)
                            );
  
  S_Final_round_AES final10 (
                            .in(J), 
                            .Key(Round2key10), 
                            .out(Cipher_Test)
                            );

    key_schedule keyseh (
                           .Key(Key),
                           .Round2key1(Round2key1), 
                           .Round2key2(Round2key2), 
                           .Round2key3(Round2key3), 
                           .Round2key4(Round2key4), 
                           .Round2key5(Round2key5), 
                           .Round2key6(Round2key6), 
                           .Round2key7(Round2key7), 
                           .Round2key8(Round2key8), 
                           .Round2key9(Round2key9), 
                           .Round2key10(Round2key10)
                          );

  Regis R0 (Clk,Rst,Cipher_Testa,Cipher_Test);                          

endmodule

 /*
  Encryption_Sub    Enc (
                           .plaintext_in(plaintext_in), 
                           .ciphertext_out(ciphertext_out), 
                           .key_in(key_in),
                           .Round2key1(Round2key1), 
                           .Round2key2(Round2key2), 
                           .Round2key3(Round2key3), 
                           .Round2key4(Round2key4), 
                           .Round2key5(Round2key5), 
                           .Round2key6(Round2key6), 
                           .Round2key7(Round2key7), 
                           .Round2key8(Round2key8), 
                           .Round2key9(Round2key9), 
                           .Round2key10(Round2key10)
                           );
	*/
