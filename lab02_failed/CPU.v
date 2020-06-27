`include "defines.v"

module RISC_8bits(clk, reset);
input clk;
input reset;

reg pc_increment, mem_read, mem_write, reg_write, mem_to_reg, alu_to_reg, reg_a_to_mem, reg_b_to_mem;
wire [3:0] opcode;

wire [7:0] alu_out;

wire [1:0] reg_address1, reg_address2, reg_write_address;
wire [7:0] reg_out_data1, reg_out_data2, reg_in_data;

//reg [2:0] state, next_state;

wire [3:0] mem_address;
wire [7:0] mem_in, mem_out;

wire [3:0] ins_mem_address;
wire [7:0] instruction;

reg read_en;

assign reg_address1 = instruction[3:2];
assign reg_address2 = instruction[1:0];
assign opcode = instruction[7:4];
assign mem_address = instruction[3:0];

assign mem_in = (reg_a_to_mem)?reg_out_data1:
					 (reg_b_to_mem)?reg_out_data2:8'bzzzzzzzz;

assign reg_in_data = (alu_to_reg)?alu_out:
						 (mem_to_reg)?mem_out:8'bzzzzzzzz;
						 
assign reg_write_address = (opcode == `RD_A)?2'b00:
									(opcode == `RD_B)?2'b01:
									(opcode == `ADD || opcode == `SUB || opcode == `AND || opcode == `NOT)?reg_address2:2'bzz;


//实例化
program_counter PC(clk, reset, pc_increment, ins_mem_address);
ins_mem Ins_MEM(clk, reset, ins_mem_address, instruction);
data_ram ram(clk, reset, mem_read, mem_write, mem_address, mem_in, mem_out);
alu ALU(reg_out_data1, reg_out_data2, opcode, alu_out);
gp_register register(clk, reset, reg_in_data, reg_write_address, reg_write, reg_address1, reg_address2, reg_out_data1, reg_out_data2, read_en);

always @(posedge clk)
begin
	pc_increment = 1;
end

always @(*)
case(opcode)
	`NOP:
	begin
		mem_read = 0;
		mem_write = 0;
		reg_write = 0;
		mem_to_reg = 0;
		alu_to_reg = 0;
		reg_a_to_mem = 0;
		reg_b_to_mem = 0;
		read_en = 0;
	end
	
	`ADD:
	begin
		mem_read = 0;
		mem_write = 0;
		reg_write = 1;
		mem_to_reg = 0;
		alu_to_reg = 1;
		reg_a_to_mem = 0;
		reg_b_to_mem = 0;
		read_en = 1;
	end
	
	`SUB:
	begin
		mem_read = 0;
		mem_write = 0;
		reg_write = 1;
		mem_to_reg = 0;
		alu_to_reg = 1;
		reg_a_to_mem = 0;
		reg_b_to_mem = 0;
		read_en = 1;
	end
	
	`AND:
	begin
		mem_read = 0;
		mem_write = 0;
		reg_write = 1;
		mem_to_reg = 0;
		alu_to_reg = 1;
		reg_a_to_mem = 0;
		reg_b_to_mem = 0;
		read_en = 1;
	end
	
	`NOT:
	begin
		mem_read = 0;
		mem_write = 0;
		reg_write = 1;
		mem_to_reg = 0;
		alu_to_reg = 1;
		reg_a_to_mem = 0;
		reg_b_to_mem = 0;
		read_en = 1;
	end
	
	`RD_A:
	begin
		mem_read = 1;
		mem_write = 0;
		reg_write = 1;
		mem_to_reg = 1;
		alu_to_reg = 0;
		reg_a_to_mem = 0;
		reg_b_to_mem = 0;
		read_en = 0;
	end
	
	`RD_B:
	begin
		mem_read = 1;
		mem_write = 0;
		reg_write = 1;
		mem_to_reg = 1;
		alu_to_reg = 0;
		reg_a_to_mem = 0;
		reg_b_to_mem = 0;
		read_en = 0;
	end
	
	`WR_A:
	begin
		mem_read = 0;
		mem_write = 1;
		reg_write = 0;
		mem_to_reg = 0;
		alu_to_reg = 0;
		reg_a_to_mem = 1;
		reg_b_to_mem = 0;
		read_en = 1;
	end
	
	`WR_B:
	begin
		mem_read = 0;
		mem_write = 1;
		reg_write = 0;
		mem_to_reg = 0;
		alu_to_reg = 0;
		reg_a_to_mem = 0;
		reg_b_to_mem = 1;
		read_en = 1;
	end
	default:
	begin
		mem_read = 0;
		mem_write = 0;
		reg_write = 0;
		mem_to_reg = 0;
		alu_to_reg = 0;
		reg_a_to_mem = 0;
		reg_b_to_mem = 0;
		read_en = 0;
	end
endcase

endmodule