# Emmanuel Fowora

.data
	data: .space 1001
	output: .asciiz "\n"
	invalid_input: .asciiz "Invalid input"
.text

main:
	#storing user input
	li $v0, 8
	la $a0, data
	li $a1, 1001
	syscall
	jal beginning
	j finish

beginning:
	#checks for spaces at the beginning of the string
	la $t0,data
	add $t0,$t0,$t1
	lb $s0, ($t0)
	beq $s0, 0, end		