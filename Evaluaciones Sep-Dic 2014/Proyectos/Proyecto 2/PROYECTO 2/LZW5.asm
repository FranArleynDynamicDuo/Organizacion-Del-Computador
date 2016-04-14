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
string2:  .word 0:30
espacio:  .ascii "\n"
dic:      .align 2
	  .word  0:100       # array of 100 integers
Letra:    .asciiz  "A"
result:    .space 100
mensaje:  .ascii "IMPRIMIR "

	.text
main:	jal Inicializar
	la $t0, dic
	li $v0, 8
	la $a0, string
	li $a1, 21
	syscall
	
	li $v0, 4
	syscall
	move $t2, $a0

	li $t8, 5           # CAMBIO DE DIRECCION
	li $t1, 20
	
	jal Proc_Longitud
	beq $t5, $zero, Fin

	jal Cadena_de_caracteres
	
Mientras:

	beqz $t2, Fin
	jal Arreglo
	
	
if:	blt $s3, $t6, Cond1
	beq $s3, $t6, Cond2
	
Cond1: 
	jal Concatenar     	
       	
Buscar: 
	la  $t9, ($s7)
	jal Arreglo
	j if

Cond2: 
	jal Agregar
	jal Imprimir3
	
	lw $t9, ($s5)
	la $a0, ($t9)
	li $v0, 11
	syscall
	 
	j Mientras

Fin:    add $t5, $t5, -1

	la $a0, espacio       #    PURO PRINT
	li $v0, 4             #    
	syscall               #
	
	la $a0, mensaje
	li $v0, 4
	syscall
	
	li $v0, 10            #    PURO PRINT
	syscall               #




#--------------------------INICIALIZAR EL DICCIONARIO------------------------------------#

Inicializar:         

        li   $t1, 0          # $8 is the index, and loop induction variable
        li   $t6, 26       # $13 is the sentinel value for the loop
       	lb   $t5, Letra      # $12 is the value 18, to be put in desired element
       	li   $s1, 0
       	li   $s2, 0
       	
for:    beq  $t6, $t1, fin  # CAMBIAR a imprimir
        la   $t2, dic      # $9 is the base address of the array
        mul  $t3, $t1, 4     # $10 is the offset
        add  $t4, $t3, $t2   # $11 is the address of desired element	 
        sw   $t5, ($t4)
        add  $t1, $t1, 1      # increment loop induction variable
        add  $t5, $t5, 1
        b    for
        
imprimir:
	# REUSAR LO Q ESTE AQUI YA Q ES SOLO PARA IMPRIMIR
	beq $t6, $s2, fin
	addi  $s2, $s2, 1
	lw $a0, dic($s1)
        li $v0, 11
        syscall
        addi  $s1, $s1, 4
        j imprimir

fin: jr $ra

#---------------------CALCULAR LONGITUD DE LA CADENA DE STRING---------------------------#

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
	jr $ra

#---------------------------CADENA DE CARACTERES----------------------------#

Cadena_de_caracteres:

	beq $t7,$zero, Primer_elemento_cadena
	add $t7,$t7,1
	add $t1, $t1,4
	beq $t7,$t8, Reinicio
	bne $t7,$zero, Proximo_elemento_cadena

Primer_elemento_cadena:  

	li $t7, 1
	lw $t3, 0($t2)          # SE GUARDA LA CADENA DE CARACTERES
	
	andi $t9, $t3, 0xff     # LA LETRA DESPEGADA
	la  $s4 , string2
	add $s7, $t1, $s4
	sw  $t9, ($s7)
	
	lw $a0, espacio
	beq $t9, $a0, Fin          # ESTRATEGICO
	
	la $a0, ($t9)
	li $v0, 11
	syscall
	
	jr $ra
	
Proximo_elemento_cadena:
		
	la $a0, espacio
	li $v0, 4
	syscall
	
	addu $t9, $t3, $zero
	srl $t9, $t9, 8 
	addu $t3, $t9, $zero
	andi $t9,$t3, 0xff
	
	la  $s4 , string2
	add $s7, $t1, $s4
	sw  $t9, ($s7)
	
	lw $a0, espacio            # NO MOVER LUGAR
	beq $t9, $a0, Fin          # ESTRATEGICO
	
	la $a0, ($t9)
	li $v0, 11
	syscall
	jr $ra
	
Reinicio: la $t2, 4($t2)
	  li $t7, 0
	  j Cadena_de_caracteres
	 
#-------------------------------ARREGLO-------------------------------------#

Arreglo: lw  $s0, dic($zero)             # PRIMER ELEMENTO DEL ARREGLO
	 li  $s1, 0 
	 li  $s3, 0
	 
Buscar_Arreglo: 

	la $a0, ($s3)
	li $v0, 1
	syscall
	beq $s3,$t6, Retorno
	beq $t9,$s0, Retorno
	add $s3, $s3, 1
	add $s1,$s1, 4                    # SIGUIENTES ELEMENTOS DEL ARREGLO	
	lw $s0, dic($s1)
	la $a0, ($s0)
	li $v0, 11
	syscall
	j Buscar_Arreglo
	
Retorno:  
	jr $ra

#------------------------------CONCATENAR-----------------------------------#

Concatenar:

	la $s6, ($s7)	
	jal  Cadena_de_caracteres
	la $a0, ($s6)   
	la $s5, ($s7)               # GUARDAR PARA IMPRIMIR
	la $a1, ($s7)
	la $a2, result
		
copyFirstString:  
   	lb $s4, ($a0)                  # get character at address  
   	beqz $s4, copySecondString
   	sb $s4, ($a2)                  # else store current character in the buffer  
   	addi $a0, $a0, 1               # string1 pointer points a position forward  
   	addi $a2, $a2, 1               # same for finalStr pointer  
   	j copyFirstString              # loop 
   
copySecondString:
   	lb $s4, ($a1)                  # get character at address  
   	beqz $s4, final
   	sb $s4, ($a2)                  # else store current character in the buffer  
   	addi $a1, $a1, 1               # string1 pointer points a position forward  
   	addi $a2, $a2, 1               # same for finalStr pointer  
   	j copySecondString            # loop 
   
final:
	la $a0, result
	li $v0, 4
	syscall
	la $s7, result
        
        j Buscar

	
#----------------------------------AGREGAR-----------------------------------------#

Agregar: 
	 lwr  $a0, 0($s7)
	 add $t4, $t4, 4
	 sw $a0, ($t4)
	 jr $ra

#---------------------------------IMPRIMIR-----------------------------------------#

Imprimir3: 

	lw $t9, ($s6)
	la $a0, ($t9)
	li $v0, 11
	syscall
	
	jal Arreglo

	la $a0, mensaje
	li $v0, 4
	syscall 
	
	la $a0, ($s3)
	li $v0, 1
	syscall
	
	la $s7, ($s5)
	
	la $a0, ($s7)
	li $v0, 11
	syscall 
	
	lw $t9, ($s6)
	
	j Mientras
	
	

	
