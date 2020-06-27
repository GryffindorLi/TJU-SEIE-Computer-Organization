//OPCODES     
`define NOP 4'b0000  //空操作
`define ADD 4'b0001  //加
`define SUB 4'b0010  //减法
`define AND 4'b0011  //与
`define NOT 4'b0100  //非
`define RD_A 4'b0101  //读内存到寄存器A
`define RD_B 4'b0110  //读到B
`define WR_A 4'b0111  //写A到内存
`define WR_B 4'b1000

//STATES
`define IF 3'b000
`define ID 3'b001
`define EXE 3'b010
`define MEM 3'b011
`define WB 3'b100