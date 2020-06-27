`timescale 1ns/1ns

module CPUtest_tb();
reg sys_clk;

initial 
    begin
        $dumpfile("wave.vcd");
        $dumpvars(1,CPUtest_tb);
    end
initial 
	begin

        	#500 $finish;
    end
initial 
    begin
        sys_clk <= 1'b0;
        forever
       #5 sys_clk<=~sys_clk;
    end
    vvcpu CPUtest_tb(.CLK(sys_clk));
endmodule
