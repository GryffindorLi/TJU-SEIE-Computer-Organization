# 8-Bits RISC CPU

## CPU组成

本CPU是一个单周期CPU，无流水线结构。该CPU结构中包括4个通用寄存器，一个指令存储器和一个数据存储器，控制单元。指令存储器和数据存储器各有一个16Bytes的RAM组成。

## ISA

本CPU支持以下指令：

```verilog
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
```

其中具体指令格式如下：

| ADD, SUB, AND | opcode[7:4] | src[3:2]/oprand1 | dst[1:0]/oprand2 |
| ------------- | ----------- | ---------------- | ---------------- |
| NOT           | opcode[7:4] | src[3:2]         | dst[1:0]         |
| RD, WR        | opcode[7:4] | address[3:2]     | address[1:0]     |

## ALU

```verilog
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
```

两个操作数，一个结果，由opcode进行控制。

## 数据存储器

```verilog
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
```

输入地址即可读出数据，时钟上升沿时可写入数据。

## 通用寄存器

```verilog
`include "defines.v"

module gp_register(clk,reset,in_data,in_address,reg_write,out_address1, out_address2, out_data1,out_data2, read_en);
input clk, reset;
input reg_write, read_en; //写入控制信号，读取控制信号
    input [7:0] in_data;  //写入数据
    input [1:0] in_address; //写入地址

    input [1:0] out_address1;  //读取地址1 
    input [1:0] out_address2;//读取地址2

    output [7:0] out_data1;  //读出数据1
    output [7:0] out_data2;  //读出数据2

reg [7:0] data [3:0];

    wire [7:0] test1, test2;  //两个测试信号

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
```

## 指令存储器

```verilog
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
```

指令存储器只可读，不可写。

## PC

```verilog
`include "defines.v"

module program_counter(clk, reset, increment, out);

input clk, reset;
input increment;  //此信号没用

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
```

PC也只可读，不可写。本指令集中无跳转指令，因此每个时钟周期，PC+1。

## CPU内部连线

```verilog
module RISC_8bits(clk, reset);
input clk;
input reset;

reg pc_increment, mem_read, mem_write, reg_write, mem_to_reg, alu_to_reg, reg_a_to_mem, reg_b_to_mem;
    //pc_increment是个没用的信号，其余对应是内存读、内存写、寄存器读、内存到寄存器的数据选择，alu到寄存器数据选择，寄存器a去内存，寄存器b去内存
    wire [3:0] opcode; //opcode

    wire [7:0] alu_out; //alu输出结果

    wire [1:0] reg_address1, reg_address2, reg_write_address; //读取和写入寄存器地址
    wire [7:0] reg_out_data1, reg_out_data2, reg_in_data; //读出和写入寄存器数据

//reg [2:0] state, next_state;

    wire [3:0] mem_address; //读写内存地址
    wire [7:0] mem_in, mem_out;//写入和读出的数据内存数据

    wire [3:0] ins_mem_address; //指令存储器地址
    wire [7:0] instruction; //指令

reg read_en;  //寄存器读许可

//指令个部分含义
assign reg_address1 = instruction[3:2];
assign reg_address2 = instruction[1:0];
assign opcode = instruction[7:4];
assign mem_address = instruction[3:0];

    assign mem_in = (reg_a_to_mem)?reg_out_data1:   //内存写入来源
					 (reg_b_to_mem)?reg_out_data2:8'bzzzzzzzz;

    assign reg_in_data = (alu_to_reg)?alu_out:  //寄存器写入来源
						 (mem_to_reg)?mem_out:8'bzzzzzzzz;
						 
    assign reg_write_address = (opcode == `RD_A)?2'b00:  //寄存器写入地址来源
									(opcode == `RD_B)?2'b01:
									(opcode == `ADD || opcode == `SUB || opcode == `AND || opcode == `NOT)?reg_address2:2'bzz;


//实例化
program_counter PC(clk, reset, pc_increment, ins_mem_address);
ins_mem Ins_MEM(clk, reset, ins_mem_address, instruction);
data_ram ram(clk, reset, mem_read, mem_write, mem_address, mem_in, mem_out);
alu ALU(reg_out_data1, reg_out_data2, opcode, alu_out);
gp_register register(clk, reset, reg_in_data, reg_write_address, reg_write, reg_address1, reg_address2, reg_out_data1, reg_out_data2, read_en);
```

