	.file	"fac.c"
	.option nopic
# GNU C17 (xPack GNU RISC-V Embedded GCC, 64-bit) version 8.3.0 (riscv-none-embed)
#	compiled by GNU C version 7.4.0, GMP version 6.1.2, MPFR version 3.1.6, MPC version 1.0.3, isl version isl-0.18-GMP

# GGC heuristics: --param ggc-min-expand=30 --param ggc-min-heapsize=4096
# options passed:  -imultilib rv32im/ilp32
# -iprefix d:\embed-gcc\xpack\risc-v embedded gcc\8.3.0-1.1\bin\../lib/gcc/riscv-none-embed/8.3.0/
# -isysroot d:\embed-gcc\xpack\risc-v embedded gcc\8.3.0-1.1\bin\../riscv-none-embed
# fac.c -march=rv32im -mabi=ilp32 -fverbose-asm
# options enabled:  -faggressive-loop-optimizations -fauto-inc-dec
# -fchkp-check-incomplete-type -fchkp-check-read -fchkp-check-write
# -fchkp-instrument-calls -fchkp-narrow-bounds -fchkp-optimize
# -fchkp-store-bounds -fchkp-use-static-bounds
# -fchkp-use-static-const-bounds -fchkp-use-wrappers -fcommon
# -fdelete-null-pointer-checks -fdwarf2-cfi-asm -fearly-inlining
# -feliminate-unused-debug-types -ffp-int-builtin-inexact -ffunction-cse
# -fgcse-lm -fgnu-runtime -fgnu-unique -fident -finline-atomics
# -fira-hoist-pressure -fira-share-save-slots -fira-share-spill-slots
# -fivopts -fkeep-static-consts -fleading-underscore -flifetime-dse
# -flto-odr-type-merging -fmath-errno -fmerge-debug-strings -fpeephole
# -fplt -fprefetch-loop-arrays -freg-struct-return
# -fsched-critical-path-heuristic -fsched-dep-count-heuristic
# -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
# -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
# -fsched-stalled-insns-dep -fschedule-fusion -fsemantic-interposition
# -fshow-column -fshrink-wrap-separate -fsigned-zeros
# -fsplit-ivs-in-unroller -fssa-backprop -fstdarg-opt
# -fstrict-volatile-bitfields -fsync-libcalls -ftrapping-math -ftree-cselim
# -ftree-forwprop -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
# -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop
# -ftree-reassoc -ftree-scev-cprop -funit-at-a-time -fverbose-asm
# -fzero-initialized-in-bss -mdiv -mexplicit-relocs -mplt -mstrict-align

	.text
	.align	2
	.globl	prints
	.type	prints, @function
prints:
	addi	sp,sp,-32	#,,
	sw	s0,28(sp)	#,
	addi	s0,sp,32	#,,
	sw	a0,-20(s0)	# ptr, ptr
# fac.c:2:     asm("li a7, 1");
 #APP
# 2 "fac.c" 1
	li a7, 1
# 0 "" 2
# fac.c:3:     asm("ecall");
# 3 "fac.c" 1
	ecall
# 0 "" 2
# fac.c:4: }
 #NO_APP
	nop	
	lw	s0,28(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	prints, .-prints
	.align	2
	.globl	fac
	.type	fac, @function
fac:
	addi	sp,sp,-48	#,,
	sw	ra,44(sp)	#,
	sw	s0,40(sp)	#,
	addi	s0,sp,48	#,,
	sw	a0,-36(s0)	# n, n
# fac.c:9: 	if(n<1)
	lw	a5,-36(s0)		# tmp76, n
	bgt	a5,zero,.L3	#, tmp76,,
# fac.c:10: 		return 0;
	li	a5,0		# _4,
	j	.L4		#
.L3:
# fac.c:11: 	else if(n==0||n==1)
	lw	a5,-36(s0)		# tmp77, n
	beq	a5,zero,.L5	#, tmp77,,
# fac.c:11: 	else if(n==0||n==1)
	lw	a4,-36(s0)		# tmp78, n
	li	a5,1		# tmp79,
	bne	a4,a5,.L6	#, tmp78, tmp79,
.L5:
# fac.c:12: 		res=1;
	li	a5,1		# tmp80,
	sw	a5,-20(s0)	# tmp80, res
	j	.L7		#
.L6:
# fac.c:14: 		res=n*fac(n-1);
	lw	a5,-36(s0)		# tmp81, n
	addi	a5,a5,-1	#, _1, tmp81
	mv	a0,a5	#, _1
	call	fac		#
	mv	a4,a0	# _2,
# fac.c:14: 		res=n*fac(n-1);
	lw	a5,-36(s0)		# tmp83, n
	mul	a5,a5,a4	# tmp82, tmp83, _2
	sw	a5,-20(s0)	# tmp82, res
.L7:
# fac.c:15: 	return res;
	lw	a5,-20(s0)		# _4, res
.L4:
# fac.c:16: }
	mv	a0,a5	#, <retval>
	lw	ra,44(sp)		#,
	lw	s0,40(sp)		#,
	addi	sp,sp,48	#,,
	jr	ra		#
	.size	fac, .-fac
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32	#,,
	sw	ra,28(sp)	#,
	sw	s0,24(sp)	#,
	addi	s0,sp,32	#,,
# fac.c:20: 	int n=4;
	li	a5,4		# tmp74,
	sw	a5,-20(s0)	# tmp74, n
# fac.c:22: 	result = fac(n);
	lw	a0,-20(s0)		#, n
	call	fac		#
	sw	a0,-24(s0)	#, result
# fac.c:23: 	prints(result);
	lw	a0,-24(s0)		#, result
	call	prints		#
# fac.c:24: 	return 0;
	li	a5,0		# _6,
# fac.c:25: }
	mv	a0,a5	#, <retval>
	lw	ra,28(sp)		#,
	lw	s0,24(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	main, .-main
	.ident	"GCC: (xPack GNU RISC-V Embedded GCC, 64-bit) 8.3.0"
