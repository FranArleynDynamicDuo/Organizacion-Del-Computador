		.kdata	
msg:		.asciiz "Trap generated\n"
msg1:		.asciiz "DO"
letras:		.byte 122, 120, 99, 118, 98, 110, 109
registros:	.word 0, 1, 2, 3, 4, 5, 6, 7
negro:      	.word 0x0
blanco:      	.word 0xffffff
rojo:      	.word 0xff0000
verde:  	.word 0x00ff00
azul: 	     	.word 0x0000ff
naranja:	.word 0xFFA500
amarillo:	.word 0xFFFF00
indigo: 	.word 0x4B0082
violeta:	.word 0xEE82EE

		.ktext 0x80000180
		move $k0,$v0   # Save $v0 value
		move $k1,$a0   # Save $a0 value
		
		la   $a0, msg1  # address of string to print
		li   $v0, 4    # Print String service
		syscall
		
		#Respaldo los registros que voy a usar
   		sw $t0, registros
		sw $t1, registros+4
		sw $t2, registros+8
		sw $a0, registros+12
		sw $a1, registros+16
		sw $a2, registros+20
		sw $a3, registros+24
		sw $v0, registros+28
		
		#Para hacer la llamada al generador de midi
inicializo:	li $a1, 500	#Longitud del tono
		li $a2, 0
		li $a3, 100	#Volumen
		li $v0, 31

		#Reviso que tecla se marco	
		lb $t0, 0xffff0004
		lb $t1, letras
		beq $t0, $t1, do
		lb $t1, letras+1
		beq $t0, $t1, re
		lb $t1, letras+2
		beq $t0, $t1, mi
		lb $t1, letras+3
		beq $t0, $t1, fa
		lb $t1, letras+4
		beq $t0, $t1, sol
		lb $t1, letras+5
		beq $t0, $t1, la
		lb $t1, letras+6
		beq $t0, $t1, si
		j continuar
         
do:		lw $a0, rojo
		jal colorear
		li $a0, 60
		j sonido

re:		lw $a0, naranja
		jal colorear
		li $a0, 62
		j sonido
		
mi:		lw $a0, amarillo
		jal colorear
		li $a0, 64
		j sonido
		
fa:		lw $a0, verde
		jal colorear
		li $a0, 65
		j sonido
		
sol:		lw $a0, azul
		jal colorear
		li $a0, 67
		j sonido
		
la:		lw $a0, indigo
		jal colorear
		li $a0, 69
		j sonido
		
si:		lw $a0, violeta
		jal colorear
		li $a0, 71
		j sonido

sonido:		syscall
		j continuar
		
colorear:	li $t0, 0
		li $t1, 0x4000
c_ciclo:	beq $t0, $t1, s_colorear
		lui $t2, 4097
		add $t2, $t2, $t0
		sw $a0, ($t2)
		addi $t0, $t0, 4
		j c_ciclo
s_colorear:	jr $ra

continuar:	la   $a0, msg1  # address of string to print
		li   $v0, 4    # Print String service
		syscall
		
		move $v0,$k0   # Restore $v0
		move $a0,$k1   # Restore $a0
		mfc0 $k0,$14   # Coprocessor 0 register $14 has address of trapping instruction
		addi $k0,$k0,4 # Add 4 to point to next instruction
		mtc0 $k0,$14   # Store new address back into $14
		
salir:		#Restauro los registros
		lw $t0, registros
		lw $t1, registros+4
		lw $t2, registros+8
		lw $a0, registros+12
		lw $a1, registros+16
		lw $a2, registros+20
		lw $a3, registros+24
		lw $v0, registros+28
		eret           # Error return; set PC to value in $14
