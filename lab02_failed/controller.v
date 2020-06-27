`include "defines.v"

module controller(clk, reset, instruction, pc_increment, mem_read, mem_write, opcode, reg_write);
//加一个数据选择控制，将alu结果和read_mem在写回时分开

input clk, reset;
input [7:0] instruction;

output pc_increment, mem_read, mem_write, reg_write;
output [3:0] opcode;

reg [7:0] ins;

assign opcode = ins[3:0];

always @(posedge clk or reset)
begin
	if (reset)
	begin
		ins <= 8'b0;
	end
	case(state)
		`IF: begin
		pc_increment = 1;
		end
		
		`ID, `EXE: 
		begin
			pc_increment = 0;
			mem_read = 0;
			mem_write = 0;
			reg_write = 0;
		end
		
		`MEM:
		case(opcode)
			`RD:
			begin
				mem_read = 1;
				pc_increment = 0;
				mem_write = 0;
				reg_write = 0;
			end
			`WR:
			begin
				mem_read = 0;
				pc_increment = 0;
				mem_write = 1;
				reg_write = 0;
			end
			default:
			begin
				mem_read = 0;
				pc_increment = 0;
				mem_write = 0;
				reg_write = 0;
			end
		endcase
		
		`WB:
		case(opcode)
			`RD,`ADD,`SUB,`AND,`NOT:
			begin
				reg_write = 1;
				mem_read = 0;
				pc_increment = 0;
				mem_write = 0;
			end
			default:
			begin
				mem_read = 0;
				pc_increment = 0;
				mem_write = 0;
				reg_write = 0;
			end
		endcase
	endcase
end

endmodule	