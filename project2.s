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

special_characters:
	#checks for special characters
    addi $t1,$t1, 1
    beq $s0, 9, space 
    beq $s0, 32, space
    beq $s0, 10, converts
    j not_valid
    
space:
   #checks for spaces
    addi $t3,$t3, -1
    j while 
 
integer:
	#checks for a specific character type
    ble $s0, 47, special_characters
    addi $t1, $t1, 1
    addi $t2, $t2, 1    
    li $t5, 48
    sub $s0, $s0, $t5
    mul $t3, $t3, $t7
    j while
    
uppercase:
	#checks for a specific character type
    ble $s0, 64, special_characters
    addi $t1, $t1, 1
    addi $t2, $t2, 1
    li $t5, 55
    sub $s0, $s0, $t5
    mul $t3, $t3, $t7
    j while

lowercase:
	#checks for a specific character type
    ble $s0, 96, special_characters
    addi $t1, $t1, 1
    addi $t2, $t2, 1    
    li $t5, 87
    sub $s0, $s0, $t5
    mul $t3, $t3, $t7
    j while   

converts:
	#converts the different character types
    la $t0, data
    add $t0,$t0,$t6
    lb $s0, ($t0)
    addi $t2,$t2, -1
    addi $t6, $t6, 1
    blt $t2,0,done
    move $t8, $t2
    j sorts
                
sorts:
	#sorts the different charcater types
    ble $s0, 57, num
    ble $s0, 86, upper
    ble $s0, 118, lower

num:
	#checks for numbers
    li $t5, 48
    sub $s0, $s0, $t5
    li $t9, 1
    beq $t2, 0, combine
    li $t9, 32
    j exponent
upper:
	#checks for uppercase letters
    li $t5, 55
    sub $s0, $s0, $t5
    li $t9, 1
    beq $t2, 0, combine
    li $t9, 32
    j exponent
lower:
	#checks for lowercase letters
    li $t5, 87
    sub $s0, $s0, $t5
    li $t9, 1
    beq $t2, 0, combine
    li $t9, 32
    j exponent
   
exponent:
	#multiplies the base by a certain exponent
    ble $t8, 1, combine
    mul $t9, $t9, 32
    addi $t8, $t8, -1
    j exponent
combine:
	#adds the values together
    mul $s2, $t9, $s0
    add $s1, $s1, $s2
    li $t9, 1
    j converts
done: jr $ra    

end:
   #ends the program
    li $v0, 4
    la $a0, output
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    j Exit    
   
not_valid:
	#checks for invalid character types
    li $v0, 4
    la $a0, output
    syscall 
    li $v0, 4
    la $a0, notvalid
    syscall
    j Exit

Exit:
    li $v0, 10
    syscall    
    
   
    
                                 