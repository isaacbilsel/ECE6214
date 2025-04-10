`timescale 1ns / 1ps

module reset_synchronization (
    input wire clk,
    input wire rst_n,
    output reg rst_n_sync
);

reg upsample_data_in;
reg upsample_data_mid;


always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rst_n_sync <= 0;
        upsample_data_mid <= 0;
        upsample_data_in <= 0;
    end else begin
        rst_n_sync <= upsample_data_mid;
        upsample_data_mid <= upsample_data_in;
        upsample_data_in <= 1'b1;
    end
end

endmodule
