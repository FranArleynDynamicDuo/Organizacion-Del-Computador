	.data
inicio:	.word 0
espacio: .asciiz " "

#$t0: Temporal para el contenido de la lista
#$t1: Elemento actual de la lista
#$t2: Contador para el ciclo de impresion

	.text
main:
	#Reservamos espacio para el primer elemento
	li $v0, 9
	li $a0, 8
	syscall

	#Guardamos la direccion de inicio de la lista en "inicio"
	sw $v0, inicio

	move $t1, $v0	
	
	li $t0, 1
	sw $t0, ($t1)
	
	#Reservamos espacio para el segundo elemento
	li $v0, 9
	li $a0, 8
	syscall
	
	sw $v0, 4($t1)
	lw $t1, 4($t1)
	
	#Almacenamos el segundo elemento
	li $t0, 2
	sw $t0, ($t1)
	
	#Reservamos espacio para el tercer elemento
	li $v0, 9
	li $a0, 8
	syscall
	
	sw $v0, 4($t1)
	lw $t1, 4($t1)
	
	#Almacenamos el tercer elemento
	li $t0, 3
	sw $t0, ($t1)
	
	#Terminda la creacion, ahora se imprime
	li $t2, 3
	lw $t1, inicio
ciclo:
	beqz $t2, fin
	addi $t2, $t2, -1	

	li $v0, 1
	lw $a0, ($t1)
	syscall
	li $v0, 4
	la $a0, espacio
	syscall

	#Avanzo al siguiente
	lw $t1, 4($t1)
	b ciclo
	
fin:
	li $v0, 10
	syscall
