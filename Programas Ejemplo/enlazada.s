#Cada item de la lista es un apuntador al elemento y un apuntador al siguiente

	.data
lista:		.word	0	#Apuntador a la lista donde voy a trabajar
salto:		.asciiz "\n"
t_asignar:	.asciiz "Asignando 42\n"
t_crear:	.asciiz "Creando la lista\n"
t_insertar:	.asciiz "Insertando\n"
t_imprimir:	.asciiz "Imprimiendo\n"
t_obtener:	.asciiz "Obteniendo\n"
t_tamano:	.asciiz "Tamano\n"

		.text
main:		la $a0, t_crear
		li $v0, 4
		syscall
		jal crear	#Creo la lista
		sw $v0,	lista
		
		li $s0, 0
		li $s1, 3
c_insertar:	beq $s0, $s1, imprimo
		li $v0, 9	#Creo un elemento para insertarlo en la lista
		li $a0, 4
		syscall
		addi $s0, $s0, 1
		sw $s0, ($v0)

		lw $a0, lista
		move $a1, $v0		
		jal insertar
		j c_insertar

imprimo:	la $a0, t_imprimir
		li $v0, 4
		syscall
		lw $a0, lista #Imprimo la lista
		jal imprimir
		
		la $a0, t_obtener
		li $v0, 4
		syscall
		lw $a0, lista	#Obtengo un elemento de la lista
		li $a1, 0
		jal obtener
		
		beqz $v0, fin
		lw $a0, ($v0)
		li $v0, 1
		syscall
		li $v0, 4
		la $a0, salto
		syscall
		
		la $a0, t_asignar
		li $v0, 4
		syscall
		li $v0, 9	#Asigno a un elemento de la lista
		li $a0, 4
		syscall
		
		li $t0, 42
		sw $t0, ($v0)
		lw $a0, lista 
		move $a1, $v0
		li $a2, 0
		jal asignar

		la $a0, t_imprimir
		li $v0, 4
		syscall
		lw $a0, lista #Imprimo la lista
		jal imprimir

		la $a0, t_tamano
		li $v0, 4
		syscall
		lw $a0, lista #Imprimo el tamano de la lista
		li $a1, 0
		jal tamano
		
		move $a0, $v0
		li $v0, 1
		syscall
						
		j fin
		
fin:		li $v0, 10
		syscall
		
#Crea una lista vacia, retorna la direccion donde esta reservado el espacio
crear:		li $v0, 9
		li $a0, 8
		syscall
		sw $zero, ($v0)
		sw $zero, 4($v0)
		jr $ra
	
#Inserta un elemento al final de la lista.
#Registros
#$a0, apuntador al primer elemento de la lista
#$a1, apuntador al elemento de la lista
insertar:	move $fp, $sp #Prologo
		sw $fp, ($sp) 
		subi $sp, $sp, 4
		sw $ra, ($sp)
		subi $sp, $sp, 4
		
		move $t0, $a0
		lw $t1, ($t0)
		beqz $t1, vacio	#Si el primer apuntador es nulo, la lista esta vacia
		
		lw $t1, 4($t0)
		beqz $t1, ultimo
		lw $a0, 4($t0)
		j insertar
		
vacio:		sw $a1, ($t0)	#El primer elemento de la lista esta vacio, asi que simplemente inserto
		j r_insertar
		
ultimo:		li $v0, 9	#Inserto un nuevo elemento en la lista
		li $a0, 8
		syscall
		sw $a1, ($v0)
		sw $v0, 4($t0)
		sw $zero, 4($v0)
		j r_insertar
		
r_insertar:	lw $ra, 4($sp) #Epilogo
		addi $sp, $sp, 4
		lw $fp, 4($sp)
		addi $sp, $sp, 4
		jr $ra
		
#Imprime la lista de manera recursiva
#Registros
#$a0, apuntador al primer elemento de la lista
imprimir:	move $fp, $sp #Prologo
		sw $fp, ($sp) 
		subi $sp, $sp, 4
		sw $ra, ($sp)
		subi $sp, $sp, 4
	
		move $t0, $a0
		lw $t1, ($t0)
		beqz $t1, r_imprimir	#Si la lista esta vacia no imprimo nada
		li $v0, 1
		lw $a0, ($t1)
		syscall
		li $v0, 4
		la $a0, salto
		syscall
		
		lw $a0, 4($t0) #Llamada recursiva si hay mas elementos
		beqz $a0, r_imprimir
		jal imprimir
		
		
r_imprimir:	lw $ra, 4($sp) #Epilogo
		addi $sp, $sp, 4
		lw $fp, 4($sp)
		addi $sp, $sp, 4
		jr $ra

#Imprime la lista de manera recursiva
#Registros
#$a0, apuntador al primer elemento de la lista
#$a1, elemento a obtener
obtener:	move $fp, $sp #Prologo
		sw $fp, ($sp) 
		subi $sp, $sp, 4
		sw $ra, ($sp)
		subi $sp, $sp, 4
		
		move $t0, $a0
		move $v0, $zero
		lw $t1, ($t0)
		move $v0, $t1
		beqz $a1, r_obtener
		
		subi $a1, $a1, 1
		lw $a0, 4($t0)
		move $v0, $zero
		beqz $a0, r_obtener
		jal obtener

r_obtener:	lw $ra, 4($sp) #Epilogo
		addi $sp, $sp, 4
		lw $fp, 4($sp)
		addi $sp, $sp, 4
		jr $ra

#Asigna un elemento en una posicion de la lista.
#Registros
#$a0, apuntador al primer elemento de la lista
#$a1, apuntador al elemento a asignar
#$a2, posicion a insertar
asignar:	move $fp, $sp #Prologo
		sw $fp, ($sp) 
		subi $sp, $sp, 4
		sw $ra, ($sp)
		subi $sp, $sp, 4
		
		move $t0, $a0		
		move $v0, $zero
		beqz $a2, a_llegue	#Avanzo hasta llegar al indicado
		subi $a2, $a2, 1
		lw $a0, 4($t0)
		beqz $a0, r_asignar	#Se acabo la listan antes de llegar al indicado
		jal asignar
		
r_asignar:	lw $ra, 4($sp) #Epilogo
		addi $sp, $sp, 4
		lw $fp, 4($sp)
		addi $sp, $sp, 4
		jr $ra
		
a_llegue:	sw $a1, ($t0)	#El primer elemento de la lista esta vacio, asi que simplemente inserto
		li $v0, 1
		j r_asignar
		
#Cuenta los elementos de la lista de manera recursiva
#Registros
#$a0, apuntador al primer elemento de la lista
#$a1, debe ser cero para iniciar la cuenta
tamano:		move $fp, $sp #Prologo
		sw $fp, ($sp) 
		subi $sp, $sp, 4
		sw $ra, ($sp)
		subi $sp, $sp, 4
	
		move $t0, $a0
		move $v0, $a1
		lw $t1, ($t0)
		beqz $t1, r_tamano	#Si la lista esta vacia tamano es 0
		addi $a1, $a1, 1
		move $v0, $a1
		
		lw $a0, 4($t0) #Llamada recursiva si hay mas elementos
		beqz $a0, r_tamano
		jal tamano
		
		
r_tamano:	lw $ra, 4($sp) #Epilogo
		addi $sp, $sp, 4
		lw $fp, 4($sp)
		addi $sp, $sp, 4
		jr $ra