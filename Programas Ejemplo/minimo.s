# Planificacion de los Registros
#   ###############################
#
#   $2 : Almacena el numero que por el momento es el minimo
#   $3 : Almacena siguiente numero a comparar de la secuencia original
#   $4 : Almacena la direcion del siguiente numero a comparar de la secuencia original
#   $5 : Contador que indica cuantos numeros restan por procesar 
#
#   Este es el primer y el ultimo programa donde los registros seran identificados
#    por su numero y no por su alias ( $t0, $t1, $s0, $1, $a0, etc )

	    .data
Start:      .word   5, 4, 3, 10, 2, 16
minimo:     .word   0
men1:    	.asciiz "El minimo es:"
		.text

main:		li		$5, 6
            la		$4, Start
            lw		$2, 0($4)     # En el registro tengo el candidato a minimo
loop:       addi   	$4, $4, 4
            addi   	$5, $5, -1
            beq    	$5, $0, fin
            lw    	$3, 0($4)     # Cargo el siguiente valor a ver si es < que el minimo
            ble    	$2, $3, loop
            move  	$2, $3
            j           loop            
fin:     	sw          $2, minimo
           	la          $a0, men1    # Llamada al sistema para imprimir un mensaje de texto
           	li          $v0, 4
           	syscall
           	lw          $a0, minimo  # Llamada al sistema para imprimir un numero entero
          	li          $v0, 1
           	syscall
           	li          $v0, 10      # Llama al sistema para finalizar el programa
           	syscall