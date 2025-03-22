`timescale 10ns / 10ps

module AES_tb; 

    // Testbench Signals
    reg clk;
    reg rst_n;
    reg start_encryption;
    reg [127:0] plaintext_in;
    reg [127:0] key_in;
    wire [127:0] ciphertext_out;
    wire encryption_done;

    // Instantiate the AES Encryption Top Module
    AES uut (
        .clk(clk),
        .rst_n(rst_n),
        .plaintext_in(plaintext_in),
        .key_in(key_in),
        .ciphertext_out(ciphertext_out)
        .encryption_done(encryption_done),
        .start_encryption(start_encryption)
    );

    // Clock Generation: Toggle clock every 5ns to create a 100 MHz clock
    always begin
        #5 clk = ~clk;
    end

    // Test Stimulus: Apply inputs to the design under test
    initial begin
        // Initialize the clock and reset signals
        clk = 0;
        rst_n = 0;

        // Apply Reset to initialize the AES core
        $display("Applying reset...");
        rst_n = 1;
        #10; // Wait for a few clock cycles to apply reset
        rst_n = 0;

        // Test 1: Apply given plaintext and key
        $display("Starting Test 1: Apply given plaintext and key...");
        
        // Given Plaintext (128 bits)
        plaintext_in = 128'h0004080c0105090d02060a0e0307070b0f;  // 4x4 matrix as provided

        // Given Key (128 bits)
        key = 128'h00020406080a0c0e10121416181a1c1e;  // 4x4 matrix as provided
        
        // Wait for the encryption process to complete
        #10;  
        
        // Display the resulting ciphertext
        $display("Ciphertext: %h", ciphertext_out);

        // End simulation after the test
        $finish;
    end

    // Monitor the output Cipher_Test at each time step
    initial begin
        $monitor("At time %t, cipher = %h", $time, ciphertext_out);
    end

endmodule
