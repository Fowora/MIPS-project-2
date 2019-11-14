# Emmanuel Fowora
.data #Data declaration sector
my_string: .space 2000
invalid_input: .asciiz "This input is invalid"

.text

main:
	li $v0, 8 #takes in user input
	la $a0, my_string
	syscall
	
	