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
   always @(posedge SCLK or negedge rst_n)
     begin
	if(rst_n == 1'b0)begin
	   reg_read_data <= 8'd0;
	   for(i = 0; i <= 255; i = i + 1)begin
	      register_array_data_current[i] <= 8'd0;
	   end
	end else begin
	   reg_read_data <= reg_read_data_next;
	   for(i = 0; i <= 255; i = i + 1)begin
	      register_array_data_current[i] <= register_array_data_next[i];
	   end
	end // else: !if(rst_n == 1'b0)
     end // always @ (posedge SCLK or negedge rst_n)

   //combinational logic
   always @(*)
     begin

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
