####################################################################################################
#                                        PROTECTO 2 LZW                                            #
#                            Nombre: Francisco Sucre  Carnet: 10-10717                             #
#                                    Arleyn Goncalves         10-10290                             #
####################################################################################################

# $t0 = Contiene el diccionario inicializado
# $t1 = Contador para saber el tama-o de la cadena ingresada
# $t2 = Contiene la cadena de carateres ingresada
# $t3 y $t4 = Se usan para hacer el procedimiento para desprender los caracteres
# $t5 = Contiene el tama-o de la Cadena de Carateres

	.data
string:   .asciiz " "
largo:     .word 0
id:        .word 0
espacio:  .ascii "\n"
dic:      .word 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
	.text
	
main:	la $t0, dic          # ARREGLO	

	li $v0,8
	la $a0, string
	li $a1, 21
	syscall
	
	move $t2, $a0       # SE GUARDO LA CADENA INGRESADA
	move $a0,$t2
	li $v0, 4
	syscall
	
	li $t8, 4   # NO LO HE COPIADO
	li $t1, 0           # CONTADOR PARA EL LARGO DE LA CADENA
	la $a0, ($t1)
	li $v0, 1
	syscall
	li $t6, 0          # INDICE DEL ARREGLO
	la $a0, ($t6)
	li $v0, 1
	syscall
	j Proc_Longitud
	
Primer_elemento_cadena:  

	li $t7, 1
	lw $t3, 0($t2)          # SE GUARDA LA CADENA DE CARACTERES
	andi $t4, $t3, 0xff     # LA LETRA DESPEGADA
	la $a0, espacio
	li $v0, 4
	syscall
	la $a0, ($t4)
	li $v0, 11
	syscall
	j Arreglo

Proximo_elemento_cadena:

	la $a0, ($t1)
	li $v0, 1
	syscall
	add $t1,$t1,1
	la $a0, ($t1)
	li $v0, 1
	syscall
	beq $t7,$t8,Reinicio
	add $t7,$t7,1
	#beq $t5,$t1,fin   NNO LO NECESITO
	la $a0, espacio
	li $v0, 4
	syscall
	
	addu $t4, $t3, $zero
	srl $t4, $t4, 8 
	addu $t3, $t4, $zero
	andi $t4,$t3, 0xff
	la $a0, ($t4)
	li $v0, 11
	syscall
	j Arreglo
	
Reinicio: la $t2, 4($t2)
	  li $t7, 1
	  j Primer_elemento_cadena
	  	
#--------- CALCULAR LONGITUD DEL STRING -----------#

Proc_Longitud: move $s0, $t2

Longitud:
	lbu $t5, ($s0)
	beq $t5, $zero, Final_Longitud
	addiu $s0,$s0,1
	j Longitud
	
Final_Longitud:
	sub $v0,$s0,$t2
	addi $t5,$v0,-1
	la $a0, ($t5)
	li $v0, 1
	syscall
	j Primer_elemento_cadena
	
#---------- VERIFICAR LOS DATOS DEL ARREGLO --------#

Arreglo: lw  $s0, dic($zero)             # PRIMER ELEMENTO DEL ARREGLO
	 la  $s1, ($t6)

Buscar_Arreglo:

	beq $t4,$s0,Proximo_elemento_cadena	
	add $s1,$s1,4                    # SIGUIENTES ELEMENTOS DEL ARREGLO
	lw $s0, dic($s1)
	la $a0, ($s0)
	li $v0,11
	syscall
	j Buscar_Arreglo
	
#---------------------CONCATENAR-------------------#
	
fin:	li $v0, 10
	syscall
	
# REVISAR LOS CONTADORES IMPORTANTE
	
	
