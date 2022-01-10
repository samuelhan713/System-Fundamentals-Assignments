.data
	A: .word 2, 7, 4, 9, 3, 7, 3, 6, 7, 1
	msg1: .asciiz "Enter a number to search for: "
	outMsg1: .asciiz "FOUND IT"
	outMsg2: .asciiz "TOO BAD"
.text

main:
	la $a0, msg1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall

	la $a0, A         #$a0 = base address of array
	la $a1, 11        #$a1 = number of elements in array (inclusive of last element)
	move $a2, $v0     #$a2 = N	
	li $t0, 0         #counter
	
	jal FindN         #call to function

	move $t2, $v0     #store the return value to $t2
	
	beq $t2, $zero, tooBad

foundIt:
	la $a0, outMsg1
	li $v0, 4
	syscall
	j end

tooBad:
	la $a0, outMsg2
	li $v0, 4
	syscall

end:
	li $v0, 10
	syscall
	
	
FindN: 
	li $t3, 1           #for return value when found
repeat:
	lw $t1, 0($a0)
	addi $a0, $a0, 4    #move pointer
	addi $t0, $t0, 1    #counter = counter + 1
	
	beq $t0, $a1, notFound  #if counter == size
	bne $t1, $a2, repeat    #if the counter != element, repeat

found:
	move $v0, $t3
	j done

notFound:
	move $v0, $zero
	
done:
	jr $ra
