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
  
	// instantiate modules
	
	// key expansion
	key_expand k (clk, key, key1,key2,key3,key4,key5,key6,key7,key8,key9,key10);
	
	// Initial add round key 
  assign A = plaintext_in ^ key;
  
  // Rounds 1-9
	round rounda (.text(A), .key(key1), .out(B));
	round roundb (.text(B), .key(key2), .out(C));
	round roundc (.text(C), .key(key3), .out(D));
	round roundd (.text(D), .key(key4), .out(E));
	round rounde (.text(E), .key(key5), .out(F));
	round roundf (.text(F), .key(key6), .out(G));
	round roundg (.text(G), .key(key7), .out(H));
	round roundh (.text(H), .key(key8), .out(I));
	round roundi (.text(I), .key(key9), .out(J));

	// Final round
  final_round finalj (.in(J), .key(key10), .out(Cipher_Test)); 

  always @(posedge clk) begin
    if (rst_n) begin
      ciphertext_out = 128'd0;
    end
    else begin
      // Register values
			
    end
  end
    

endmodule
