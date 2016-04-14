############################################################################################
#				           Estrucutura Pila Con Funciones						#
#				       Francisco Sucre  Carnet: 10-10717					#
############################################################################################
	
	.data

elementos: .word 1,2,3,4
cant: .word 4
Pila: 	.word 0:10
    	.space 40
    	
    	.text
	.globl main	

main:

	la $a0, elementos
	lw $a1, cant
	la $a2,Pila
	jal push
	
push:		

	# $t0 es la direccion de inicio del arreglo elementos
	# $t1 es la cantidad de elementos en el arreglo
	# $t3 es la posicion en la que estamos en la pila

	move $t1,$a1		# Llevo los parametros de entrada a  los registros $t
	move $t0,$a0
	la $t3,40($a2)
	
loop: 

	beqz $t1, fin
	lw $t4,0($t3)
	addi $t0,$t0,4
	addi $t3,$t3,-4
	addi $t1,$t1,-1
	b loop

pop:

	beqz $t1,f_1
	lw $a0, 4($t3)
	li $v0,1
	syscall
	addiu $t3,$t3,4
	addi $t1,$t1,-1
	j pop

fin:

	move  $v0, $t3

f_1:

	li $v0,10             # Exit
      	syscall