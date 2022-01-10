.data
	msg1: .asciiz "Enter a number: "
	msg2: .asciiz "The sum is: "
.text

main:
	la $a0, msg1
	li $v0, 4
	syscall

	li $v0, 5
	syscall

	move $a0, $v0    #preparing argument $a0

	jal sumSq
	
	move $t0, $v0    #store return value in $t0

	la $a0, msg2     #printing output message
	li $v0, 4
	syscall

	move $a0, $t0    #printing the result
	li $v0, 1
	syscall

	li $v0, 10
	syscall           

sumSq:
	addi $sp, $sp, -12  #allocate space for 2 slots
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	sw $a1, 8($sp)

	beq $a0, 0, done
	
	li $v0, 0            #reinitialize $v0 to 0
	mul $a1, $a0, $a0    #$a1 = #a0^2
	sub $a0, $a0, 1      #$a0 = $a0 - 1

	jal sumSq            #recursive call
	add $v0, $a1, $v0    #$v0 = $a1+$v0
	
done:
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	lw $a1, 8($sp)
	addi $sp, $sp, 12
	jr $ra



	
