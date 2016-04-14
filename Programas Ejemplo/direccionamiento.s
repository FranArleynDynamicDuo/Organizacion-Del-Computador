# Planificacion de los Registros
#   ###############################
#
#   $2 : Almacena el numero que por el momento es el minimo
#   $3 : Almacena siguiente numero a comparar de la secuencia original
#   $4 : Almacena la direcion del siguiente numero a comparar de la secuencia original
#   $5 : Contador que indica cuantos numeros restan por procesar 

	    .data
reg1:		.word	1234567
			.asciiz "Pedro Perez"
			.align 2
reg2:		.word	7654321
			.asciiz "Petra Perez"
		.text

main:		li			$v0, 1			#Direccionamiento por simbolo
			la			$a0, reg1
			syscall
			
			la			$a0, reg1+4		#Direccionamiento por simbolo + desplazamiento
			li			$v0, 4
			syscall
			
			li			$t0, 16
			la			$a0, reg1+16(reg1)		#Direccionamiento por simbolo + desplazamiento
			li			$v0, 1
			syscall
			
fin:     	li          $v0, 10      # Llama al sistema para finalizar el programa
           	syscall