	.data
pila:	.word 0
espacio: .asciiz " "
	.text
main:
	sw $sp, pila
	li $t2, 2
	li $t3, 1
	sw $t3, ($sp)
	addi $sp, $sp, -4
	
	li $t3, 2
	sw $t3, ($sp)
	addi $sp, $sp, -4
	
	li $t3, 3
	sw $t3, ($sp)
	addi $sp, $sp, -4

imprimir:	
	li $v0, 1
	lw $a0, 4($sp)
	syscall
	addi $sp, $sp, 4
	li $v0, 4
	la $a0, espacio
	syscall

	li $v0, 1
	lw $a0, 4($sp)
	syscall
	addi $sp, $sp, 4
	li $v0, 4
	la $a0, espacio
	syscall

	li $v0, 1
	lw $a0, 4($sp)
	syscall
	addi $sp, $sp, 4
	
	li $v0, 10
	syscall
