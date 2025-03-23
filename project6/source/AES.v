`timescale 10ns / 10ps

module AES(clk,rst_n,plaintext_in,key_in,start_encryption,ciphertext_out, encryption_done);
  input wire clk, rst_n;
  input wire start_encryption;
  input wire [127:0] plaintext_in;
  input wire [127:0] key_in;
  output reg [127:0] ciphertext_out;
  output reg encryption_done;

  // Register inputs and outputs
  reg start_encryption_q;
  reg [127:0] plaintext_in_q;
  reg [127:0] key_in_q;
  reg [127:0] ciphertext_out_next;
  reg encryption_done_next;

  wire [127:0] key0,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10;
  // wire [127:0] ciphertext_out;
  wire [127:0] A,B,C,D,E,F,G,H,I,J;
  wire [127:0] ciphertext_out_wire;
  
	// Instantiate modules
	// Key expansion
	key_expand k (clk, key_in_q, key0,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10);
	
	// Initial add round key 
  assign A = plaintext_in_q ^ key_in_q;
  
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
  final_round final10 (.in(J), .key(key10), .out(ciphertext_out_wire)); 

  always @(posedge clk or negedge rst_n) begin
    if (rst_n) begin
      ciphertext_out      <= 128'd0;
      encryption_done     <= 1'b0;
      start_encryption_q  <= 1'b0;
      plaintext_in_q      <= 128'd0;
      key_in_q            <= 128'd0;
    end
    else begin
      // Register values
			start_encryption_q  <= start_encryption;
      plaintext_in_q      <= plaintext_in;
      key_in_q            <= key_in;
      encryption_done     <= encryption_done_next;
      ciphertext_out      <= ciphertext_out_next;
    end
  end

  always @(*) begin
    ciphertext_out_next   <= ciphertext_out;
    encryption_done_next  <= encryption_done;
    
    ciphertext_out_next = ciphertext_out_wire;
    if (ciphertext_out_next != 128'd0)
      encryption_done_next = 1'b1;
  end
    

endmodule
