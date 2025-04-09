// Code your design here
`timescale 1ns / 1ps
module modulator_64qam_top(
    input wire SCLK,
    input wire MOSI,
    input wire CSN,
    input wire rst_n,
    output wire MISO_enable, 
    output wire MISO
    );
    //internal signals
    wire [7:0] reg_read_data;
    wire [9:0] reg_addr;
    wire [7:0] reg_write_data;
    wire reg_write_enable;
    wire reg_read_enable;

    //interfacing
    spi_interface m1(
    .SCLK(SCLK),
    .MOSI(MOSI),
    .CSN(CSN),
    .rst_n(rst_n),
    .reg_read_data(reg_read_data),
    .MISO(MISO),
    .MISO_enable(MISO_enable),
    .reg_addr(reg_addr),
    .reg_write_data(reg_write_data),
    .reg_write_enable(reg_write_enable),
    .reg_read_enable(reg_read_enable)
    );
    register m2(
    .SCLK(SCLK),
    .rst_n(rst_n),
    .reg_addr(reg_addr),
    .reg_write_data(reg_write_data),
    .reg_read_data(reg_read_data),
    .reg_write_enable(reg_write_enable),
    .reg_read_enable(reg_read_enable)
    );
endmodule

module spi_interface(
    input wire SCLK,
    input wire MOSI,
    input wire CSN,
    input wire rst_n,
    input wire [7:0] reg_read_data,
    output reg MISO,
    output reg MISO_enable,
    output reg [9:0] reg_addr,
    output reg [7:0] reg_write_data,
    output reg reg_write_enable,
    output reg reg_read_enable
    );

    //internal registers
    reg [7:0] spi_shift_reg_current;
    reg [2:0] state_current;
    reg [5:0] bit_count_current;
    reg reg_rw_current;
    reg MISO_pos_edge;
    reg MISO_enable_pos_edge;
    reg [7:0] MISO_buffer_current;
    //internal combinational registers
    reg [7:0] spi_shift_reg_next;
    reg [2:0] state_next;
    reg [5:0] bit_count_next;
    reg reg_rw_next;
    reg MISO_next;
    reg MISO_enable_next;
    reg [7:0] reg_addr_next;
    reg [7:0] reg_write_data_next;
    reg reg_write_enable_next;
    reg reg_read_enable_next;
    reg [7:0] MISO_buffer_next;

    //FSM Definition
    parameter [2:0] S0_IDLE = 3'b000;
    parameter [2:0] S1_RW = 3'b001;
    parameter [2:0] S2_REG_ADDR = 3'b010;
    parameter [2:0] S3_WRITE = 3'b011;
    parameter [2:0] S4_READ = 3'b100;
    //sequential logic
    always @(posedge SCLK or negedge rst_n) begin
        if(rst_n == 1'b0) begin
            state_current <= S0_IDLE;
            spi_shift_reg_current <= 8'h00;
            bit_count_current <= 6'd33;
            reg_rw_current <= 1'b0;
            reg_addr <= 10'd0;
            MISO_pos_edge <= 1'b0;
            MISO_enable_pos_edge <= 1'b0;
            MISO_buffer_current <= 8'h00;
            reg_write_data <= 8'h00;
            reg_write_enable <= 1'b0;
            reg_read_enable <= 1'b0;
        end else begin // if (rst_n == 1'b0)
            state_current <= state_next;
            spi_shift_reg_current <= spi_shift_reg_next;
            bit_count_current <= bit_count_next;
            reg_rw_current <= reg_rw_next;
            reg_addr <= reg_addr_next;
            MISO_pos_edge <= MISO_next;
            MISO_enable_pos_edge <= MISO_enable_next;
            MISO_buffer_current <= MISO_buffer_next;
            reg_write_data <= reg_write_data_next;
            reg_write_enable <= reg_write_enable_next;
            reg_read_enable <= reg_read_enable_next;
        end // else: !if(rst_n == 1'b0)
    end // always @ (posedge SCLK or negedge rst_n)

    //falling edge logic for MISO
    always @(negedge SCLK or negedge rst_n) begin
        if(rst_n == 1'b0)begin
            MISO <= 1'b0;
            MISO_enable <= 1'b0;
        end else begin
            MISO <= MISO_pos_edge;
            MISO_enable <= MISO_enable_pos_edge;
        end
    end
    always @(*) begin
        spi_shift_reg_next = {spi_shift_reg_current[6:0], MOSI};
    end
    
    always @(*) begin
    if(MISO_enable == 1'b1)begin
    MISO_next = MISO_buffer_current[7];
    MISO_buffer_next = {MISO_buffer_current[6:0], 1'b0};
    end
    state_next = state_current;
    bit_count_next = bit_count_current;
    reg_rw_next = reg_rw_current;
    reg_addr_next = reg_addr;
    reg_write_data_next = reg_write_data;
    reg_write_enable_next = reg_write_enable;
    reg_read_enable_next = reg_read_enable;
    MISO_enable_next = MISO_enable_pos_edge;
    MISO_buffer_next = MISO_buffer_current;
    MISO_next = MISO_pos_edge; 
    case(state_current)
    S0_IDLE: begin
 if(CSN == 1'b0)begin
state_next = S1_RW;
bit_count_next = bit_count_current - 1'b1;
 end
 end
 S1_RW: begin
 state_next = S2_REG_ADDR;
 reg_rw_next = spi_shift_reg_current[0];
 bit_count_next = bit_count_current - 1'b1;
 end
 S2_REG_ADDR: begin
 bit_count_next = bit_count_current - 1'b1;
 if(bit_count_current == 6'd22)begin
if(reg_rw_current == 1'b0)begin
 state_next = S3_WRITE;
end else begin
 state_next = S4_READ;
end
reg_addr_next = spi_shift_reg_current[9:0];
 end
 end 
 S3_WRITE: begin
 bit_count_next = bit_count_current - 1'b1; 
 reg_write_enable_next = 1'b1;
 if(bit_count_current == 6'd5)begin
reg_write_data_next = spi_shift_reg_current;
 end else if(bit_count_current == 6'd0)begin

state_next = S0_IDLE;
bit_count_next = 6'd33;
reg_write_enable_next = 1'b0;
 end
 end
 S4_READ: begin
 reg_read_enable_next = 1'b1;
 MISO_buffer_current = reg_read_data;
 bit_count_next = bit_count_current - 1'b1;
 if(bit_count_current == 6'd15)begin
MISO_enable_next = 1'b1;
 end else if(bit_count_current == 6'd0)begin
 state_next = S0_IDLE;
 bit_count_next = 6'd33;
 MISO_enable_next = 1'b0;
 end 
 end
endcase 
 end 
endmodule 

`timescale 1ns / 1ps
module register_array(
		      input wire	 SCLK,
		      input wire	 rst_n,
		      input wire [9:0]	 reg_address,
		      input wire [7:0]	 reg_write_data,
		      input wire	 reg_write_enable,
		      input wire	 reg_read_enable,
		      output reg [7:0] reg_read_data
		      );

   //internal registers
   reg [7:0]			 register_array_data_current[0:255];

   //internal combinational variables
   reg [7:0]			 register_array_data_next[0:255];
   reg [7:0]			 reg_read_data_next;

   //loop variables
   integer			 i;
   integer			 j;

    //sequential logic
    always @(posedge SCLK or negedge rst_n) begin
        if(rst_n == 1'b0)begin
            reg_read_data <= 8'h00;
            for(i = 0; i <= 255; i = i + 1)begin
                register_array_data_current[i] <= 8'h00;
            end
        end else begin
            reg_read_data <= reg_read_data_next;
            for(i = 0; i <= 255; i = i + 1)begin
                register_array_data_current[i] <= register_array_data_next[i];
            end
        end // else: !if(rst_n == 1'b0)
    end // always @ (posedge SCLK or negedge rst_n)

    //combinational logic
    always @(*) begin
        reg_read_data_next = reg_read_data;
        for(j = 0; j <= 255; j = j + 1)begin
        register_array_data_next[j] = register_array_data_current[j];
        end

        if(reg_write_enable == 1'b1)begin
        register_array_data_next[reg_address] = reg_write_data;
        end

        if(reg_read_enable == 1'b1)begin
        reg_read_data_next = register_array_data_current[reg_address];
        end
    end // always @ (*)
endmodule // register_array

/*
module register(
 input wire SCLK,
 input wire rst_n,
 input wire [9:0] reg_addr,
 input wire [7:0] reg_write_data,
 input wire reg_write_enable,
 input wire reg_read_enable,
 output reg [7:0] reg_read_data
 );
 //internal registers
 reg [7:0] reg_data_next[0:255]; 
 reg [7:0] reg_data_current[0:255];
 reg [7:0] reg_read_data_next;
 //loop variables
 integer i;
 integer j;
 //sequential logic
 always @(posedge SCLK or negedge rst_n)
 begin
if(rst_n == 1'b0)begin
 reg_read_data <= 8'h00;

 for(i = 0; i <= 255; i = i + 1)begin
 reg_data_current[i] <= 8'h00;
 end
end else begin
 reg_read_data <= reg_read_data_next;
 for(i = 0; i <= 255; i = i + 1)begin
 reg_data_current[i] <= reg_data_next[i];
 end
end 
 end 
 //combinational logic
 always @(*)
 begin
reg_read_data_next = reg_read_data;
for(j = 0; j <= 255; j = j + 1)begin
 reg_data_next[j] = reg_data_current[j];
end
if(reg_read_enable == 1'b1)begin
 reg_read_data_next = reg_data_current[reg_addr];
 end
 if(reg_write_enable == 1'b1)begin
 reg_data_next[reg_addr] = reg_write_data;
end
 end 
endmodule
*/