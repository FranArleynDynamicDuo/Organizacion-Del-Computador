####################################################################################################
#                                        PROTECTO 2 LZW                                            #
#                            Nombre: Francisco Sucre  Carnet: 10-10717                             #
#                                    Arleyn Goncalves         10-10290                             #
####################################################################################################

	.data
result:    .space 100       # espacio donde se van a guardar las palabras concatenadas
string:   .asciiz " "       # Variable donde se guarda el string ingresado por el usuario
string2:  .word 0:30        # Espacio donde se va a guardar letra por letra el String
espacio:  .asciiz "\n"      # Usado para parar el programa (Cuando se termina el uso del string) 
dic:      .align 2          # Arreglo de 100 espacios, donde se guardara el inicio del diccionario
	  .word  0:100      # y las palabras concatenadas
Letra:    .asciiz  "A"      # Letra inicial a guardar en el diccionario
space:     .ascii " "       # Usado para la impresion.

	.text
	
#------------------------------------PRINCIPAL---------------------------------------#
	
main:	jal Inicializar    # Se inicializa el diccionario
	la $t0, dic        # Se guarda en t0
	
	li $v0, 8          # Se ingresa la cadena de caracteres
	la $a0, string
	li $a1, 21	   # LONGITUD DE LA CADENA DE CARACTERES INGRESADA POR EL USUARIO
	syscall
	
	move $t2, $a0      # Se guarda en $t2, la cadena de caracteres ingresada

	li $t8, 5          
	li $t1, 20
	
	jal Cadena_de_caracteres    # Llama procedimieto para separar la primera letra del 
				    # la cadena de caracteres ingresada por el usuario
	
Mientras:

	jal Arreglo		    # Llama el procedimiento Arreglo para buscar si la cadena de
				    # caracteres, se encuentra o no se encuentra en el arrreglo  

if:	blt $s3, $t6, Cond1  # Si $s3 < $t6, se concatena
	beq $s3, $t6, Cond2  # Si $s3 = $t6, se imprime
	
Cond1: 
	jal Concatenar     	    # Llama procedimiento parra concatenar
       	
Buscar: 
	lw  $t9, 0($s7)
	jal Arreglo
	j if

Cond2: 
	jal Agregar
	jal Imprimir		    # Llama procedimiento para imprimir indice del arreglo
	
	lw $t9, ($s5) 
	j Mientras

Fin:    
	li $v0, 10            #    PURO PRINT
	syscall               #

#--------------------------INICIALIZAR EL DICCIONARIO------------------------------------#

# Se inicializa el diccionario se toman las letras desde la A hasta la Z (No incluye la Ñ)

Inicializar:         

        li   $t1, 0          # Contador
        li   $t6, 26         # Total de letras a ingresar
       	lb   $t5, Letra      # letra inicial (A)
       	
for:    beq  $t6, $t1, fin  # Condicio para que cuando el contador llegue a 26 pare
        la   $t2, dic      
        mul  $t3, $t1, 4    
        add  $t4, $t3, $t2    
        sw   $t5, ($t4)     # Se guarda en el arreglo
        add  $t1, $t1, 1      
        add  $t5, $t5, 1
        b    for

fin: jr $ra

#---------------------------CADENA DE CARACTERES----------------------------#

# Este procedimiento se usa para separar cada una de las letras ingresadas
# en el string por el usuario. Se puede observa que en Cadena_de_caracteres
# hay como la opcion de ingreso al primer elemento, el proximo o reinicio.
# Esto se programo de esta manera ya que en la memoria, cada 4 palabras ingresadas
# se guarda en diferente direccion de memoria

Cadena_de_caracteres:

	beq $t7,$zero, Primer_elemento_cadena      # Caso para la primera letra
	add $t7,$t7,1
	add $t1, $t1,4
	beq $t7,$t8, Reinicio                      # Se mueve la direccion de memoria
	bne $t7,$zero, Proximo_elemento_cadena     # Los proximos elementos despues del primero

Primer_elemento_cadena:  

	li $t7, 1
	lw $t3, 0($t2)          
	andi $t9, $t3, 0xff     # Uso de la mascara para separar las letras
	
	la  $s4 , string2       # Guarda la letra en la direccion de memoria
	add $s7, $t1, $s4
	sw  $t9, ($s7)
	
	lw $a0, espacio        # Se sale si llega al final del la cadena de caracteres
	beq $t9, $a0, Fin      
	
	jr $ra
	
Proximo_elemento_cadena:
	
	addu $t9, $t3, $zero    # Uso de la mascara para separar las letras
	srl $t9, $t9, 8 
	addu $t3, $t9, $zero
	andi $t9,$t3, 0xff
	la  $s4 , string2      # Guarda la letra en la direccion de memoria
	add $s7, $t1, $s4
	sw  $t9, ($s7)
	
	lw $a0, espacio        # Se sale si llega al final del la cadena de caracteres 
	beq $t9, $a0, Fin          
	
	jr $ra
	
Reinicio: la $t2, 4($t2)       # Se mueve la direccion de memoria
	  li $t7, 0
	  j Cadena_de_caracteres 
	 
#-------------------------------ARREGLO-------------------------------------#

Arreglo: lw  $s0, dic($zero)             # Primer elemento del arreglo
	 li  $s1, 0 			 # Usado para el desplazamiento en la memoria
	 li  $s3, 0                      # Contador (Indice del arreglo)
	 
Buscar_Arreglo: 

	beq $s3,$t6, Retorno             # Sale si llega hasta le final del arreglo
	beq $t9,$s0, Retorno		 # Sale si encuentra el elemento
	add $s3, $s3, 1
	add $s1,$s1, 4                   # Desplazamiento en la direccion de memoria	
	lw $s0, dic($s1)
	j Buscar_Arreglo
	
Retorno:  
	jr $ra

#------------------------------CONCATENAR-----------------------------------#

# Procedimiento en la cual se concatena letras

Concatenar:

	la $s6, ($s7)	
	lw $s2, ($s6)
	jal  Cadena_de_caracteres
	la $a0, ($s6)   		# Primera letra
	la $s5, ($s7)                 
	la $a1, ($s7)			# Segunda letra
	la $a2, result
	
		
copyFirstString:  
   	lb $s4, ($a0)                  # Se obtiene el elemento de la direccion  
   	beqz $s4, copySecondString
   	sb $s4, ($a2)                  # Se toma una direccion   
   	addi $a0, $a0, 1               # Apuntador para la Primera Letra 
   	addi $a2, $a2, 1                 
   	j copyFirstString              
   
copySecondString:
   	lb $s4, ($a1)                  # Se obtiene el elemento de la direccion
   	beqz $s4, final
   	sb $s4, ($a2)                  # Se toma una direccion
   	addi $a1, $a1, 1               # Apuntador para la Primera Letra 
   	addi $a2, $a2, 1                 
   	j copySecondString           
   
final:
	la $a0, result			# Se guarda el resultado en $a0
	la $s7, ($a0)
        j Buscar

#----------------------------------AGREGAR-----------------------------------------#

# Procedimiento para agregar las palabras concatenadas y que todavia no se encuentran
# en el diccionario

Agregar: 
	 la  $a0, ($t9)
	 add $t4, $t4, 4	# Continuacion de la direccion de memoria del arreglo
	 add $t6, $t6, 1	# Aumentamos en 1 el tamaño del arreglo
	 sw $a0, ($t4)          # Se guarda en la direccion de memoria asignada
	 li $t5, 0		
	 sw $t5, result		# Reinicio en la direccion de memoria donde esta la palabra concatenada
	 jr $ra

#---------------------------------IMPRIMIR-----------------------------------------#

# Procedimiento donde se imprime la posicion dee la letra en el arreglo

Imprimir: 

	la $t9, ($s2)
	
	jal Arreglo
	
	la $a0, ($s3)       # $s3 Contiene la posicion de la letra en el diccionario
	li $v0, 1
	syscall
	
	la $a0, space      # Se usa para la formalizacion de la impresion
	li $v0, 4
	syscall 
	
	la $s7, ($s5)
	lw $t9, ($s5)
	j Mientras
