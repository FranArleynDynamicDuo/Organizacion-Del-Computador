		.data
mensaje1: 	.asciiz   "Los numeros primos que se estan generando son: " 
mensaje2: 	.asciiz   "La sumatoria de los  numeros primos generados es: "
coma: 	.asciiz   ", "
mensaje3:	.asciiz	"Fin del Programa"
linea: 	.asciiz  "\n"
		.align 2
max:		.word	5
primos: 	.word 1,1,2,3,2,1,-1,1
sumprim:	.word	 1     
		.text
main:
		li	$t0, 0
		li	$t1, 1
		li	$s1, 1
		li   $s3, 1
		li	$s4, 0

		la	$a0, mensaje1
		li	$v0, 4
		syscall

		la	$a0, linea
		li	$v0, 4
		syscall

		li	$a0, 1
		li	$v0, 1
		syscall

		la	$a0, coma
		li	$v0, 4
		syscall

		lw	$s2, max
     		addi  $s2, $s2, -1
ciclo1:	
	
		addi	$t1, $t1, 1
		move	$t2, $t1
	
ciclo2:	
		add	$t2, $t2,-1
		div	$t1, $t2
		mfhi	$t3
		beq	$t2, $s1, esprimo	
		bnez	$t3, ciclo2

		j ciclo1

esprimo:
		move	$a0, $t1
		li	$v0, 1
		syscall

		la	$a0, coma
		li	$v0, 4
		syscall

     		add   $s3, $s3, $t1	
		addi	$s4, $s4, 4
		sw	$t1, primos($s4)
		sw 	$s3, sumprim
		addi	$s2, $s2, -1
		bgtz	$s2, ciclo1	

		la	$a0, linea
		li	$v0, 4
		syscall

		la	$a0, mensaje2
		li	$v0, 4
		syscall

		move	$a0, $s3
		li	$v0, 1
		syscall

		la	$a0, linea
		li	$v0, 4
		syscall

		la	$a0, mensaje3
		li	$v0, 4
		syscall

		li	$v0, 10
		syscall