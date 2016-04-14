	.data
inicio:	.space 8
espacio: .asciiz " "

#$t0: Temporal para el contenido de la lista
#$t1: Ultimo elemento de la lista
#$t2: Numero de elementos de la lista -1
#$t3: Elemento a insertar

	.text
main:
	li $t2, 20
	li $t3, 1
	la $t1, inicio

ciclo1:	
	sw $t3, ($t1)
	addi $t3, $t3, 1
	
	beqz $t2, imprimir
	addi $t2, $t2, -1
	#Reservamos espacio para el siguiente elemento
	li $v0, 9
	li $a0, 8
	syscall
	
	sw $v0, 4($t1)
	move $t1, $v0
	
	b ciclo1
	
imprimir:
	#Terminda la creacion, ahora se imprime
	la $t1, inicio
ciclo:
	li $v0, 1
	lw $a0, ($t1)
	syscall
	li $v0, 4
	la $a0, espacio
	syscall

	#Avanzo al siguiente
	lw $t1, 4($t1)
	beqz $t1, fin
	b ciclo
	
fin:
	li $v0, 10
	syscall
