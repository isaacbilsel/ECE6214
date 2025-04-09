module tb_TopModule;

    reg clk;
    reg rst_n;
    reg [3:0] sample_rate;
    reg [3:0] data_in;
    reg coeff_write;
    reg [7:0] coeff_in;
    reg [6:0] coeff_addr;
    reg new_symbol;
    wire [11:0] data_out;
    wire data_out_valid;

    TopModule uut (
        .clk(clk),
        .rst_n(rst_n),
        .sample_rate(sample_rate),
        .data_in(data_in),
        .coeff_write(coeff_write),
        .coeff_in(coeff_in),
        .coeff_addr(coeff_addr),
        .new_symbol(new_symbol),
        .data_out(data_out),
        .data_out_valid(data_out_valid)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Reset
        rst_n = 0;
        coeff_write = 0;
        new_symbol = 0;
        sample_rate = 4'd3;
        #20;
        rst_n = 1;

        // Load a few coefficients
        coeff_write = 1;
        coeff_addr = 0; coeff_in = 8'd10; @(posedge clk);
        coeff_addr = 1; coeff_in = 8'd20; @(posedge clk);
        coeff_addr = 2; coeff_in = 8'd30; @(posedge clk);
        coeff_write = 0;

        // Send one input symbol
        @(posedge clk);
        data_in = 4'd5;
        new_symbol = 1; @(posedge clk);
        new_symbol = 0;

        // Wait a few cycles for output
        repeat (20) @(posedge clk);

        $finish;
    end
endmodule
