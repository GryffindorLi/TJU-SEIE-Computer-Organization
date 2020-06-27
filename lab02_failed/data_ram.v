`include "defines.v"

module data_ram(clk, reset, mem_read, mem_write, address, in_data, out_data);
input clk, reset;
input mem_read, mem_write;
input [3:0]address;
input [7:0] in_data;

output [7:0] out_data;

reg [7:0] data [15:0];

initial
begin
	data[0] = 8'b00000000;
	data[1] = 8'b00000010;
	data[2] = 8'b00000100;
	data[3] = 8'b00000000;
	data[4] = 8'b00000000;
	data[5] = 8'b00000000;
	data[6] = 8'b00000000;
	data[7] = 8'b00000000;
	data[8] = 8'b00000000;
	data[9] = 8'b00000000;
	data[10] = 8'b00000000;
	data[11] = 8'b00000000;
	data[12] = 8'b00000000;
	data[13] = 8'b00000000;
	data[14] = 8'b00000100;
	data[15] = 8'b00001000;
end

assign out_data = (mem_read)?data[address]:8'bzzzzzzzz;

always @(posedge clk)
begin
	if (mem_write)
	begin
		data[address] <= in_data;
	end
end

endmodule