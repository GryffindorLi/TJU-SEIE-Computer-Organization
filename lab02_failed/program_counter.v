`include "defines.v"

module program_counter(clk, reset, increment, out);

input clk, reset;
input increment;

output [3:0] out;

reg [3:0] address;

assign out = address;

initial
begin
	address <= 4'b0000;
end

always @(posedge clk)
begin
	if (reset)
	begin
		address <= 4'b0000;
	end
	else
	begin
		address <= address + 4'b0001;
	end
end
endmodule