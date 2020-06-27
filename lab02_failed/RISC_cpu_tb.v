`timescale 10ns/100ps

module RISC_cpu_tb;
	reg clock;
	reg sys_reset;
	
	RISC_8bits CPU(.clk(clock), .reset(sys_reset));
	initial
	begin
		$dumpfile("wave.vcd");
		$dumpvars(3, RISC_cpu_tb);
	end
	
	initial begin
        		sys_reset = 1'b1;
        		#10 sys_reset = 1'b0;
        		#1000 $finish;
    	end
	
	initial
	begin
        		clock     = 1'b0;
        		forever #20 clock = ~clock;
    	end
endmodule
