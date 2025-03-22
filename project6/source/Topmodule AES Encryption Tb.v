`timescale 10ns / 10ps

module Topmodule_AES_Encryption_tb; 

    // Testbench Signals
    reg clk;
    reg rst;
    reg [127:0] Plain_Test;
    reg [127:0] Key;
    wire [127:0] Cipher_Test;

    // Instantiate the AES Encryption Top Module
    Topmodule_AES_Encryption uut (
        .clk(Clk),
        .rst(Rst),
        .Plain_Test(Plain_Test),
        .Key(Key),
        .Cipher_Test(Cipher_Test)
    );

    // Clock Generation: Toggle clock every 5ns to create a 100 MHz clock
    always begin
        #5 clk = ~clk;
    end

    // Test Stimulus: Apply inputs to the design under test
    initial begin
        // Initialize the clock and reset signals
        clk = 0;
        rst = 0;

        // Apply Reset to initialize the AES core
        $display("Applying reset...");
        rst = 1;
        #10; // Wait for a few clock cycles to apply reset
        rst = 0;

        // Test 1: Apply given plaintext and key
        $display("Starting Test 1: Apply given plaintext and key...");
        
        // Given Plaintext (128 bits)
        Plain_Test = 128'h0004080c0105090d02060a0e0307070b0f;  // 4x4 matrix as provided

        // Given Key (128 bits)
        Key = 128'h00020406080a0c0e10121416181a1c1e;  // 4x4 matrix as provided
        
        // Wait for the encryption process to complete
        #10;  
        
        // Display the resulting ciphertext
        $display("Ciphertext: %h", Cipher_Test);

        // End simulation after the test
        $finish;
    end

    // Monitor the output Cipher_Test at each time step
    initial begin
        $monitor("At time %t, Cipher_Test = %h", $time, Cipher_Test);
    end

endmodule
