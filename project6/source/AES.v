`timescale 10ns / 10ps

module AES(clk,rst_n,plaintext_in,key_in,start_encryption,ciphertext_out, encryption_done);
  input clk, rst_n;
  input start_encryption;
  input [127:0] plaintext_in, key_in;
  output [127:0] ciphertext_out;
  output encryption_done;

  wire [127:0] key1,key2,key3,key4,key5,key6,key7,key8,key9,key10;
  wire [127:0] ciphertext_out;
 
	wire [127:0] A,B,C,D,E,F,G,H,I,J;
  
  always @(posedge clk) begin
    if (rst_n) begin
      ciphertext_out = 128'd0;
    end
    else begin
      // Register values

    end
  end

  always @(*) begin
    if (start_encryption) begin
      // Key expansion
      key_expand k (clk, key, key1,key2,key3,key4,key5,key6,key7,key8,key9,key10);
      
      // Initial add round key 
      assign A = plaintext_in ^ key;

      // Rounds 1-9
      round round1 (.text(A), .key(key1), .out(B));
      round round2 (.text(B), .key(key2), .out(C));
      round round3 (.text(C), .key(key3), .out(D));
      round round4 (.text(D), .key(key4), .out(E));
      round round5 (.text(E), .key(key5), .out(F));
      round round6 (.text(F), .key(key6), .out(G));
      round round7 (.text(G), .key(key7), .out(H));
      round round8 (.text(H), .key(key8), .out(I));
      round round9 (.text(I), .key(key9), .out(J));

      // Final round
      final_round final10 (.in(J), .key(key10), .out(Cipher_Test)); 
    end
  end

    

endmodule
