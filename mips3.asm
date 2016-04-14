	.data
	
Cadena: .word str
str: 	.asciiz "Mensaje a revisar"
c:	.asciiz "e"

	.text
	
main:

	lw $a0,Cadena
	lb $a1,c
	jal Find
	li $v0,10
	syscall
	
find:

	beqz $a0, Fin
	lb $t0,0($a0)
	beqz $t0,Fin
	beq $t0,$a1,encontro
	addi $a