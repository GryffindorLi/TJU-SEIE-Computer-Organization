`include "defines.v"

module ins_mem(clk, reset, address, ins);

input clk, reset;
input [3:0] address;

output [7:0] ins;

reg [7:0] mem [15:0];

assign ins = (clk)?mem[address]:8'bzzzzzzzz;

initial
begin
	mem[0] = 8'b0;
	mem[1] = 8'b01010001;
	mem[2] = 8'b01100010;
	mem[3] = 8'b00010001;
	mem[4] = 8'b00110100;
	mem[5] = 8'b01111000;
	mem[6] = 8'b10001010;
	mem[7] = 8'b01011111;
	mem[8] = 8'b01101110;
	mem[9] = 8'b00100100;
	mem[10] = 8'b00000000;
	mem[11] = 8'b00000000;
	mem[12] = 8'b00000000;
	mem[13] = 8'b00000000;
	mem[14] = 8'b00000000;
	mem[15] = 8'b00000000;
end

endmodule