.data

display: .word 0:307200

.text

la $t1, display

#Para mantener el juego activo permanentemente
main:
addi $s1,$zero,1028
#addi $s3,$zero,2400
while:
jal Snake
jal Tablero
jal Punto
jal Polling
j while 

#Se crea la cabeza del Snake, en donde asigna el color del pixel que será pintado, y lo va actualizando a medida que se realiza el movimiento
Snake:
addi $t2, $zero, 0x00ff00 
add $s7,$zero,$zero
add $s7,$t1,$s1
sw $t2, 0($s7)
addi $t2,$zero, 0x000000
add $s7,$s2,$t1
sw $t2,0($s7)
jr $ra

#Se crea el objeto (comida) en un pixel, faltó implementar que cuando la cabeza del snake y la comida estén en la misma posición
#se borre el pixel de la comida y se agregue a la cabeza (un BEQ y agregar una cola al SNAKE)
Punto:
addi $t5, $zero, 0xffffff
#add $s4,$zero,$zero
#add $s4,$t1,$s3
#sw $t5, 0($s4)
#addi $t5, $zero, 0x00ff00
sw $t5, 2400($t1) 
jr $ra

#Se establecen los límites del tablero
Tablero:
addi $t4, $zero, 0xff00ff 
sw $t4, 0($t1)
addi $t4, $zero, 0xff00ff
sw $t4, 124($t1)
addi $t4, $zero, 0xff00ff
sw $t4, 3968($t1)
addi $t4, $zero, 0xff00ff
sw $t4, 4092($t1)
jr $ra

#Hacer polling para detectar el movimiento dado por el teclado
Polling :
addi $a0,$zero,100
addi $v0,$zero,32
syscall
addi $t8,$zero,0xffff0004 
lw $t9, 0($t8) 
sw $zero,0($t8)
beq $t9, 100 , MovDer
beq $t9, 97 , MovIzq
beq $t9, 119, MovUp
beq $t9 , 115 , MovDown
j Polling

MovDer:
add $s2, $s1, $zero
add $s1,$s1,4
jr $ra 

MovIzq:
add $s2, $s1, $zero
add $s1,$s1,-4
jr $ra 

MovUp:
add $s2, $s1, $zero
add $s1,$s1,-128
jr $ra 

MovDown:
add $s2, $s1, $zero
add $s1,$s1, 128
jr $ra

Random:
sw $a0, 0($s0)  
li $a1, 2501
li $v0, 42   #random
add $a0, $a0, 1000
jr $ra
