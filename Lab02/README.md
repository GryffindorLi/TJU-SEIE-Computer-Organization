# 8位CPU设计
##指令集架构
本CPU采用长度为10bits的指令集架构，所支持的指令以及对应的opcode如下所示：

```verilog
`define ADD = 3'b001;
`define SUB = 3'b010;
`define STR_A = 3'b011;
`define LD_A = 3'b100;
`define LD_B = 3'b101;
`define JP = 3'b110;
`define JP_NEG = 3'b111;
`define HLT = 10'b000_1111111;
```

对应指令集格式 如下所示:

LD_A, LD_B, STR_A:  opcode = instruction[9:7]; Address = instruction[6:0]
ADD, SUB：opcode = instruction[9:7]；dst = instruction[3:2];  src = instruction[1:0]
JP, JP_NEG:  opcode = instruction[9:7];  PC_Address = instruction[6:0]

## RAM中的数据

初始化后，RAM的数据和指令如下：

```verilog
			RAM[7'h00] = 10'b1001111111;//内存1111111处取出数存入REG_A  
			RAM[7'h01] = 10'b1011111110;//内存1111110处取出数存入REG_B  
			RAM[7'h02] = 10'b0111111110;//将REG_A的数存入内存1111110
			RAM[7'h03] = 10'b0010000001;//对REG_A、REG_B的数进行加运算，结果存入REG_A
			RAM[7'h04] = 10'b0111111101;//将REG_A的数存入内存1111101
			RAM[7'h05] = 10'b1001111100;//内存1111100处取出数（7）存入REG_A
			RAM[7'h06] = 10'b1011111011;//内存1111011处取出数（3）存入REG_B		
		    RAM[7'h07] = 10'b0100000100;//REG_B-REG_A，结果（-4：ALU_OUT_SAVE = 4，ALU_FLAG[1]置1）存入REG_B
		    RAM[7'h08] = 10'b1110010000;//若REG_B-REG_A的结果为负数，跳转至0010000
			RAM[7'h09] = 10'b1100010100;//若REG_B-REG_A的结果为正数，跳转至0010100
			
			RAM[7'h10] = 10'b0110010010;//地址0010000 将REG_A的值存入地址为0010010
			RAM[7'h11] = 10'b0001111111;//HALT
			RAM[7'h12] = 10'b0000000000;
			RAM[7'h13] = 10'b0000000000;
			RAM[7'h14] = 10'b0110010011;//地址0010100
			RAM[7'h15] = 10'b0001111111;//HALT
			
			RAM[7'h7b] = 10'b0000000010; //1111011 --- 2
			RAM[7'h7c] = 10'b0000000111; //1111100 --- 7
			RAM[7'h7d] = 10'b0000000000; //1111101 --- 0
			RAM[7'h7e] = 10'b0000000011; //1111110 --- 3
			RAM[7'h7f] = 10'b0000000100; //1111111 --- 4
```

## 状态转移

本CPU共设计了5个状态，分别为IF，ID，EXE，WB，HALT。其中，IF为取指令状态；ID为指令解码状态；EXE是执行状态；WB为访问RAM的状态；HALT为停机状态。