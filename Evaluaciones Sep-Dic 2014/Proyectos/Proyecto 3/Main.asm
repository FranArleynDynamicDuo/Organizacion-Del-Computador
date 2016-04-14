		.data
pantalla:		.space 0x4000		
mensaje:		.asciiz "He hecho N ciclos\n"	
negro:      	.word 0x0
blanco:      	.word 0xffffff
rojo:      	.word 0xff0000
verde:  		.word 0x00ff00
azul: 	     	.word 0x0000ff

		.text
		li $t0, 1000000
		li $t1, 2
		sb $t1, 0xffff0000
		#li $t0,0
		#teqi $t0,0     # immediately trap because $t0 contains 0
		#li   $v0, 10   # After return from exception handler, specify exit service
		#syscall        # terminate normally

loop:		subi $t0, $t0, 1
		beqz $t0, imprimir
		j loop
	
imprimir:	li $v0, 4
		la $a0, mensaje
		#syscall
		li $t0, 1000000
		j loop
		
