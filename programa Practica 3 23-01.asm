############################################################################################
#				           Ocurrencias en String 						#
#				       Francisco Sucre  Carnet: 10-10717					#
############################################################################################

	
	.data
	
Cadena: 		.word str				# Por referencia
str: 		.asciiz "Mensaje a revisar"		# Por valor
c:		.asciiz "e"

	.text
	
main:

	lw $a0,Cadena
	lb $a1,c
	jal find
	move $a0,$v0
	li $v0,10
	syscall
	
find:

	beqz $a0, Fin
	lb $t0,0($a0)
	beqz $t0,Fin
	beq $t0,$a1,encontro
	addi $a0,$a0,1
	b find
	
encontro:

	add $v0,$a0,$0
	jr $ra
	
Fin: 
	li $v0,0
	jr $ra	

ocurr:	# Prologo (Preservar la informacion en la pila)

	add $sp,$sp, -12
	sw $s0,4($sp)
	sw $a1,8($sp)
	sw $ra,12($sp)
	addi $s0,$zero,0
	
lazo:
	jal find
	beqz $v0,f
	addi $s0,$s0,1
	addi $v0,1
	lw $a1,8($sp)
	b lazo
	
f:	# Epilogo (Sacar la informacion de la pila) 	

	move $v0,$s0
	lw $s0,4($sp)
	lw $a1,8($sp)
	lw $ra,12($sp)
	addi $sp,$sp,12
	jr $ra