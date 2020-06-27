`include "defines.v"

module alu(alu_in1,alu_in2,opcode,alu_out);
input [7:0] alu_in1;  //dest
input [7:0] alu_in2;  //src
input [3:0] opcode;

output reg [7:0] alu_out;


always @(*)
begin
	case(opcode)
		`NOP: alu_out = alu_out;
		`ADD: alu_out = alu_in1 + alu_in2;
		`SUB: alu_out = alu_in1 - alu_in2;
		`AND: alu_out = alu_in1 & alu_in2;
      `NOT: alu_out = ~alu_in1;
		default:
			alu_out = 8'b0;
	endcase
end
endmodule