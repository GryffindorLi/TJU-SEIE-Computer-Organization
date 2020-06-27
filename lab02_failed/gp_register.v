`include "defines.v"

module gp_register(clk,reset,in_data,in_address,reg_write,out_address1, out_address2, out_data1,out_data2, read_en);
input clk, reset;
input reg_write, read_en;
input [7:0] in_data;
input [1:0] in_address;

input [1:0] out_address1;
input [1:0] out_address2;

output [7:0] out_data1;
output [7:0] out_data2;

reg [7:0] data [3:0];

wire [7:0] test1, test2;

assign out_data1 = (read_en)?data[out_address1]:8'bzzzzzzzz;
assign out_data2 = (read_en)?data[out_address2]:8'bzzzzzzzz;


initial
begin
data[0] = 8'b0;
data[1] = 8'b0;
data[2] = 8'b0;
data[3] = 8'b0;
end

always @(posedge clk)
	begin
	if (reg_write)
		data[in_address] <= in_data;
	end
endmodule