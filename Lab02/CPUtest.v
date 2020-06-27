`timescale 1ns/1ps
`include "defines.v"
module vvcpu(CLK);
	input CLK;
	//opcode
	parameter ADD = 3'b001;
	parameter SUB = 3'b010;
	parameter STR_A = 3'b011;
	parameter LD_A = 3'b100;
	parameter LD_B = 3'b101;
	parameter JP = 3'b110;
	parameter JP_NEG = 3'b111;
	parameter HLT = 10'b000_1111111;
	
	
	reg [9:0] RAM[127:0];
	reg [9:0] REG_A;//通用寄存器
	reg [9:0] REG_B;
	reg [9:0] REG_C;
	reg [9:0] REG_D;
	reg [9:0] INSTRUCTION_REG;//指令寄存器
	reg [6:0] PC;//PC指针
	reg [9:0] ALU_RESULT;
	reg [9:0] ALU_INPUT1,ALU_INPUT2;
	reg [1:0] FLAG;    //0位为ZERO位，1位为NEG位
	reg [2:0] STATE;//状态定义：0~7
	
	//若不考虑流水线
	
	initial //寄存器初始化
		begin
			REG_A[9:0] = 10'b0000000000;
		   REG_B[9:0] = 10'b0000000000;
			REG_C[9:0] = 10'b0000000000;
			REG_D[9:0] = 10'b0000000000;
			INSTRUCTION_REG[9:0] = 10'b0000000000;
			PC[6:0] = 7'b0000000;
			ALU_RESULT[9:0] = 10'b0000000000;
			ALU_INPUT1[9:0] = 10'b0000000000;
			ALU_INPUT2[9:0] = 10'b0000000000;
			FLAG[1:0] = 2'b00;
			STATE[2:0] = 3'b000;
		end

	
	initial //RAM初始化
		begin 
			RAM[7'h00] = 10'b1001111111;
			RAM[7'h01] = 10'b1011111110;
			RAM[7'h02] = 10'b0111111110;
			RAM[7'h03] = 10'b0010000001;
			RAM[7'h04] = 10'b0111111101;
			RAM[7'h05] = 10'b1001111100;
			RAM[7'h06] = 10'b1011111011;	
		   RAM[7'h07] = 10'b0100000100;
		   RAM[7'h08] = 10'b1110010000;
			RAM[7'h09] = 10'b1100010100;
			RAM[7'h10] = 10'b0110010010;
			RAM[7'h11] = 10'b0001111111;
			RAM[7'h12] = 10'b0000000000;
			RAM[7'h13] = 10'b0000000000;
			RAM[7'h14] = 10'b0110010011;
			RAM[7'h15] = 10'b0001111111;
			RAM[7'h7b] = 10'b0000000010; 
			RAM[7'h7c] = 10'b0000000111; 
			RAM[7'h7d] = 10'b0000000000; 
			RAM[7'h7e] = 10'b0000000011; 
			RAM[7'h7f] = 10'b0000000100; 
		end

	always @(posedge CLK)
		begin
		case(STATE)
		0:
		begin	//从内存中取指令
		INSTRUCTION_REG <= RAM[PC[6:0]];
		if(INSTRUCTION_REG == HLT)
			begin
			STATE[2:0] <= 3'b100;
			end
		else
			begin 
				PC <= PC + 1;
				STATE[2:0] <= 3'b001;
			end
		end
		
		1:
		begin //解读指令
		if(INSTRUCTION_REG[9:7] == LD_A) begin
			REG_A[9:0] <= RAM[INSTRUCTION_REG[6:0]];
			STATE[2:0] <= 3'b000;
			end
		else if(INSTRUCTION_REG[9:7] == LD_B) begin
			REG_B[9:0] <= RAM[INSTRUCTION_REG[6:0]];
			STATE[2:0] <= 3'b000;
			end
		else if(INSTRUCTION_REG[9:7] == STR_A) begin
			RAM[INSTRUCTION_REG[6:0]] <= REG_A[9:0];
			STATE[2:0] <= 3'b000;
			end
			
		else if((INSTRUCTION_REG[9:7] == ADD)||(INSTRUCTION_REG[9:7] == SUB) ) begin
			case(INSTRUCTION_REG[3:0])
			4'b0000:
			begin 
			ALU_INPUT1 <= REG_A;
			ALU_INPUT2 <= REG_A;
			end
			4'b0001:
			begin
			ALU_INPUT1 <= REG_A;
			ALU_INPUT2 <= REG_B;
			end
			4'b0100:
			begin
			ALU_INPUT1 <= REG_B;
			ALU_INPUT2 <= REG_A;
			end
			4'b0101:
			begin
			ALU_INPUT1 <= REG_B;
			ALU_INPUT2 <= REG_B;
			end
			endcase
			STATE[2:0] <= 3'b010;
			end
			
			
		else if(INSTRUCTION_REG[9:7] == JP) begin
			PC[6:0] <= INSTRUCTION_REG[6:0];
			STATE[2:0] <= 3'b010;
			end
		else if((INSTRUCTION_REG[9:7] == JP_NEG) && (FLAG[1]==1) ) begin
			PC[6:0] <= INSTRUCTION_REG[6:0];
			STATE[2:0] <= 3'b010;
			end
		else begin
			STATE[2:0] <= 3'b010;
			end
		end
		
		2:
		begin //运算执行
		if(INSTRUCTION_REG[9:7] == ADD) begin
			ALU_RESULT <= ALU_INPUT1 + ALU_INPUT2;
			if(ALU_INPUT1 == 0 && ALU_INPUT2 == 0 ) begin
			FLAG[1:0] <= 2'b01;
			end
			else begin
			FLAG[1:0] <= 2'b00;
			end
		end
		else if (INSTRUCTION_REG[9:7] == SUB) begin
			ALU_RESULT <= (ALU_INPUT1 > ALU_INPUT2)?(ALU_INPUT1 - ALU_INPUT2):
							 (ALU_INPUT1 < ALU_INPUT2)?(ALU_INPUT2 - ALU_INPUT1):
							 0;
			FLAG[1:0] <= (ALU_INPUT1 > ALU_INPUT2)?2'b00:
					  (ALU_INPUT1 < ALU_INPUT2)?2'b10:
						2'b01;
		end
		STATE[2:0] <= 3'b011;
		
		end
		
		3:
		begin //运算结果返回
		if((INSTRUCTION_REG[9:7] == ADD)||(INSTRUCTION_REG[9:7] == SUB))begin
			if(INSTRUCTION_REG[3:2] == 00) begin
			REG_A <= ALU_RESULT;
			end
			else if(INSTRUCTION_REG[3:2] == 01) begin
			REG_B <= ALU_RESULT;
			end
		end
			STATE[2:0] <= 3'b000;
		end
		
		4: 
		begin //HALT 状态
		
		end
		
		default:
		begin //其他状态
			STATE[2:0] <= 3'b000;
		end
		
		endcase
		
		
		
		end
	
	endmodule