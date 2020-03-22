#	.file	"3.c"
#	.option nopic
# GNU C17 (xPack GNU RISC-V Embedded GCC, 64-bit) version 8.3.0 (riscv-none-embed)
#	compiled by GNU C version 7.4.0, GMP version 6.1.2, MPFR version 3.1.6, MPC version 1.0.3, isl version isl-0.18-GMP

# GGC heuristics: --param ggc-min-expand=30 --param ggc-min-heapsize=4096
# options passed:  -imultilib rv32im/ilp32
# -iprefix d:\embed-gcc\xpack\risc-v embedded gcc\8.3.0-1.1\bin\../lib/gcc/riscv-none-embed/8.3.0/
# -isysroot d:\embed-gcc\xpack\risc-v embedded gcc\8.3.0-1.1\bin\../riscv-none-embed
# 3.c -march=rv32im -mabi=ilp32 -fverbose-asm
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
#	.align	2
#	.globl	overflow
#	.type	overflow, @function
overflow:
	addi	sp,sp,-64	#,,
	sw	s0,60(sp)	#,
	addi	s0,sp,64	#,,
	sw	a0,-52(s0)	# p, p
# 3.c:9:      for(i=0;i<4;++i){
	sw	zero,-20(s0)	#, i
# 3.c:9:      for(i=0;i<4;++i){
	j	.L2		#
.L3:
# 3.c:10:          buf[i]=0;
	lw	a5,-20(s0)		# tmp72, i
	slli	a5,a5,2	#, tmp73, tmp72
	addi	a4,s0,-16	#, tmp79,
	add	a5,a4,a5	# tmp73, tmp73, tmp79
	sw	zero,-20(a5)	#, buf
# 3.c:9:      for(i=0;i<4;++i){
	lw	a5,-20(s0)		# tmp75, i
	addi	a5,a5,1	#, tmp74, tmp75
	sw	a5,-20(s0)	# tmp74, i
.L2:
# 3.c:9:      for(i=0;i<4;++i){
	lw	a4,-20(s0)		# tmp76, i
	li	a5,3		# tmp77,
	ble	a4,a5,.L3	#, tmp76, tmp77,
# 3.c:12:      buf[10]=p;
	lw	a5,-52(s0)		# tmp78, p
	sw	a5,4(s0)	# tmp78, buf
# 3.c:13: }
	nop	
	lw	s0,60(sp)		#,
	addi	sp,sp,64	#,,
	jr	ra		#
#	.size	overflow, .-overflow
#	.section	.rodata
#	.align	2
.LC0:
	.string	"Overflow successful"
	.text
#	.align	2
#	.globl	bad_guy
#	.type	bad_guy, @function
bad_guy:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
	sw	s0,8(sp)	#,
	addi	s0,sp,16	#,,
# 3.c:17:      printf("Overflow successful\n");
#	lui	a5,%hi(.LC0)	# tmp74,
#	addi	a0,a5,%lo(.LC0)	#, tmp74,
#	call	puts		#
# 3.c:18:      return 0;
	li	a5,0		# _3,
# 3.c:19: }
	mv	a0,a5	#, <retval>
	lw	ra,12(sp)		#,
	lw	s0,8(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
#	.size	bad_guy, .-bad_guy
#	.section	.rodata
#	.align	2
.LC1:
	.string	"Address of main = %#X\n"
#	.align	2
.LC2:
	.string	"Address of overflow = %#X\n"
#	.align	2
.LC3:
	.string	"Address of bad_guy = %#X\n"
	.text
#	.align	2
#	.globl	main
#	.type	main, @function
main:
	addi	sp,sp,-32	#,,
	sw	ra,28(sp)	#,
	sw	s0,24(sp)	#,
	addi	s0,sp,32	#,,
	sw	a0,-20(s0)	# argc, argc
	sw	a1,-24(s0)	# argv, argv
# 3.c:23:     printf("Address of main = %#X\n", main);
#	lui	a5,%hi(main)	# tmp74,
#	addi	a1,a5,%lo(main)	#, tmp74,
#	lui	a5,%hi(.LC1)	# tmp75,
#	addi	a0,a5,%lo(.LC1)	#, tmp75,
#	call	printf		#
# 3.c:24:     printf("Address of overflow = %#X\n", overflow);
#	lui	a5,%hi(overflow)	# tmp76,
#	addi	a1,a5,%lo(overflow)	#, tmp76,
#	lui	a5,%hi(.LC2)	# tmp77,
#	addi	a0,a5,%lo(.LC2)	#, tmp77,
#	call	printf		#
# 3.c:25:     printf("Address of bad_guy = %#X\n", bad_guy); 
#	lui	a5,%hi(bad_guy)	# tmp78,
#	addi	a1,a5,%lo(bad_guy)	#, tmp78,
#	lui	a5,%hi(.LC3)	# tmp79,
#	addi	a0,a5,%lo(.LC3)	#, tmp79,
#	call	printf		#
# 3.c:26:     overflow(0X00401588);
	li	a5,4198400		# tmp80,
	addi	a0,a5,1416	#,, tmp80
	call	overflow		#
# 3.c:27:     return 0;
	li	a5,0		# _6,
# 3.c:28: }
	mv	a0,a5	#, <retval>
	lw	ra,28(sp)		#,
	lw	s0,24(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
#	.size	main, .-main
#	.ident	"GCC: (xPack GNU RISC-V Embedded GCC, 64-bit) 8.3.0"
