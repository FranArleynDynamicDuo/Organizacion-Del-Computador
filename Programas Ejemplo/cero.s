	.text
main:
	li $zero, 1
	#beqz $t1, fin
	#nop
fin:
	li $v0, 1
	move $a0, $zero
	syscall
	li $v0, 10
	syscall
	
