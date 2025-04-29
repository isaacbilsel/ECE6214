//Destination Domain (BCLK side)
module multicycle_data_dst #(
    parameter DATA_WIDTH = 19
) (
    input wire bclk,
    input wire rst_n,
    input wire [DATA_WIDTH-1:0] data_hold, // From ACLK domain (constant)
    input wire load_toggle_src, // From ACLK domain (toggle signal)
    output reg [DATA_WIDTH-1:0] data_out
);

    // Synchronize toggle across clock domains
    reg toggle_ff1, toggle_ff2;
    always @(posedge bclk or negedge rst_n) begin
        if (!rst_n) begin
            toggle_ff1 <= 1'b0;
            toggle_ff2 <= 1'b0;
        end else begin
            toggle_ff1 <= load_toggle_src;
            toggle_ff2 <= toggle_ff1;
        end
    end

    // Detect toggle change (edge detection)
    wire load_pulse = (toggle_ff1 ^ toggle_ff2);

    // Load data when toggle change detected
    always @(posedge bclk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= {DATA_WIDTH{1'b0}};
        end 
        else if (load_pulse) begin
            data_out <= data_hold;
        end
    end

endmodule