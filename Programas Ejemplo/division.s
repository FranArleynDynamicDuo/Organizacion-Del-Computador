# Division - ejemplo uso registros HI y LO
# Autor:	 Roger Clotet
#

.data
fraseini:	.asciiz "Introduzca el dividendo: "
fraseini2:	.asciiz "Introduzca el divisor: "
fraseresult:	.asciiz "Cociente = "
fraseresult2:	.asciiz "Resto = "

saltolinea:		.asciiz "\n"

.text
main:
	li	$v0,	4		# Pedir dividendo
	la	$a0,	fraseini
	syscall
	
	li $v0,		5
	syscall
	move $t0, $v0
	
	li	$v0,	4		# Pedir divisor
	la	$a0,	saltolinea
	syscall
	la	$a0,	fraseini2
	syscall

	li $v0,		5
	syscall
	move $t1 $v0

	div $t0, $t1

	mfhi $t2			#$t2 <- resto
	mflo $t3			#$t3 <- cociente
		
	li	$v0,	4		# Mostrar Cociente
	la	$a0,	saltolinea
	syscall
	la	$a0,	fraseresult
	syscall
	li $v0, 1
	move $a0, $t3
	syscall
	
	li	$v0,	4		# Mostrar Resto
	la	$a0,	saltolinea
	syscall
	la	$a0,	fraseresult2
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
	
	li	$v0, 10			# salir
	syscall

	