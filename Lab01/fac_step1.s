# Howto produce executable: riscv-none-embed-gcc -march=rv32im -mabi=ilp32 -specs=nosys.specs demo.s -o demo.out

# This example shows arithmetic instructions.

.data
arg1: .word 8
#arg2: .word 2
str1:     .string "Factorial value of "
str2:     .string " is "

.text
#	.globl	main
main:
        lw  x10, arg1   # Load argument from static data
#		lw	x11, arg2
        jal ra, fact 

        # Print the result to console
        mv  a1, a0
        lw  a0, arg1
        jal ra, printResult

        # Exit program
        li a7, 10
        ecall

fact:
	addi sp, sp, -16
	sw x1, 8(sp)
	sw x10, 0(sp)

	# the circle
	addi x5, x10, -1
	bge x5, x0, L1

	# if not satisfied
	addi x10, x0, 1
	addi sp, sp, 16
	jalr x0, x1, 0
	
	# if satisfied
	L1:
	addi x10, x10, -1
	jal x1, fact
	addi x6, x10, 0
	lw x10, 0(sp)
	lw x1, 8(sp)
	addi sp, sp, 16
	mul x10, x10, x6
	ret

# --- printResult ---
# a0: Value which factorial number was computed from
# a1: Factorial result
printResult:
        mv t0, a0
        mv t1, a1
        la a0, str1
        li a7, 4
        ecall
        mv a0, t0
        li a7, 1
        ecall
        la a0, str2
        li a7, 4
        ecall
        mv a0, t1
        li a7, 1
        ecall
        ret
