# Calcula la suma de los primeros numeros pares  2 + 4 + 6 + ...   
#    almacenando el resultado en el registro $t6

		.data		# inicio del area de datos del programa

saludo:     .asciiz "Programa que calcula la suma de los primeros 5 numeros pares\n"
result:     .asciiz "El resultado de la suma es : "

		.text	

######################################
#   Planificacion de los registros
#
#   $t0   Acumulador de la suma de numeros pares
#   $t1   contendra el desplazamiento para conseguir el proximo numero a sumar
#   $t2   Almacenara el siguiente numero que sera sumado  
#   $t3   Contedra la cantidad de numeros que falta por sumar
######################################

main:						# indica el comienzo del codigo del programa

	
		li	$v0, 4			# llamada al sistema para imprimir un  string = 4
		la	$a0, saludo		# carga la direccion del string a imprimir en $a0
		syscall				# llamada al sistema para hacer la operacion de imprimir

		li	$t0, 0			# $t0 sera un acumulador inicializado en 0
		li	$t1, 2			# $t1 almacenara el valor usado para conseguir el siguiente numero par
	    li      $t2, 0 		 	# $t2 almacenara el siguiente numero a operar		 
        li      $t3, 5			# inicializa el contador empleado para controlar el ciclo

loop:	add     $t2, $t2, $t1		#  Se genera el siguiente numero par
		addi    $t3, $t3, -1            # decrementa el contador del ciclo
 		bgt	$zero, $t3, endloop	# salir del ciclo si  $zero, que tiene el valor cero, es mayor que el contenido de $t3 
		add	$t0, $t0, $t2		# $t0 = $t0 + $t2
		b	loop			# salta a loop
	
endloop:					# imprime el resultado de la operacion
		li	$v0, 4			# llamada al sistema para imprimir un  string = 4
		la	$a0, result		# carga la direccion del string a imprimir en $a0
		syscall				# llamada al sistema para hacer la operacion de imprimir

		# imprime el valor entero almacenado en $t0
		li	$v0, 1			# llamada al sistema para imprimir un integer = 1
		move	$a0, $t0		# mueve el entero a imprimir a $a0:  $a0 = $t0
		syscall				# llamada al sistema para hacer la operacion de imprimir
		
		# exit program
		li	$v0, 10			# llamada al sistema para salir = 10
		syscall				# llamada al sistema

		# linea en blanco al final para manetner a SPIM feliz!


