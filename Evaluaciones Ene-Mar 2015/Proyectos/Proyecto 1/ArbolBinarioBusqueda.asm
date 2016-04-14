#####################################################################
#                                        PROTECTO 2 LZW                                                                    #
#                            Nombre: Francisco Sucre  Carnet: 10-10717                                         #
#                                    Edgar Silva         xx-xxxxx                                                           #
#####################################################################

		

	.data

mensaje1 : .asciiz "introduzca el tamaño del arbol"
VALORES: .word 42, 35, 7, 8, 38, 70, 45, 101, 300
ES_HOJA: .byte 0, 0, 0, 1, 1, 0, 1, 0, 1
TAM: .word  9
ARBOL: .word

	.text

main: 

	li $v0, 9
	li $t0, 12
	lw $t1, TAM
	mul $a0,$t0,$t1
	syscall
	move $s0,$v0
	li $t0,4 	# usaremos t0 como un iterador para pasar de valor a hijo izquierdo y luego a hijo derecho
	li $t1,12	# usaremos t1 como un iterador para pasar de elemento en elemento
	li $t2,$zero	# Usaremos t2 como el indice del los arreglos que recorreremos en paralelo
	lw 0($s0),VALORES($t2)
	lw $a0,0($s0)
	syscall
	 
	
recorrido:



imprimir:
	


