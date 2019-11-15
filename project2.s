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
		beq $s0, 9, pass
	beq $s0, 32, pass
	move $t6, $t1
	j while

pass:
	#passes by the spaces in the string
	addi $t1, $t1,1
	j beginning	
	
while:
	#checks the rest of the characters after passing the first character
    li $t7, -1
    la $t0,data
    add $t0,$t0,$t1
    lb $s0, ($t0)
    bge $t2, 5, not_valid
    bge $t3, 1, not_valid
    j check_characters	
 
check_characters:
	#checks each character
    beq $s0, 0, converts
    ble $s0, 47, special_characters
    ble $s0, 57, integer
    ble $s0, 85, uppercase
    ble $s0, 117, lowercase
    bge $s0, 118, special_characters
       