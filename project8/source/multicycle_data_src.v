//Source Domain (ACLK side)
module multicycle_data_src #(
    parameter DATA_WIDTH = 19
) (
    input wire aclk,
    input wire rst_n,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire load_data, // 1-cycle pulse to load new data
    output reg [DATA_WIDTH-1:0] data_hold,
    output reg load_toggle
);

    always @(posedge aclk or negedge rst_n) begin
        if (!rst_n) begin
            data_hold <= {DATA_WIDTH{1'b0}};
            load_toggle <= 1'b0;
        end else begin
        if (load_data) begin
            data_hold <= data_in;
            load_toggle <= ~load_toggle; // toggle whenever loading new data
            end
        end
    end

endmodule
