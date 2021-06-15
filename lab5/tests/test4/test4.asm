#-------------------- MEMORY Mapped I/O -----------------------
#define PORT_LEDG[7-0] 0x800 - LSB byte (Output Mode)
#define PORT_LEDR[7-0] 0x804 - LSB byte (Output Mode)
#define PORT_HEX0[7-0] 0x808 - LSB byte (Output Mode)
#define PORT_HEX1[7-0] 0x80C - LSB byte (Output Mode)
#define PORT_HEX2[7-0] 0x810 - LSB byte (Output Mode)
#define PORT_HEX3[7-0] 0x814 - LSB byte (Output Mode)
#define PORT_SW[7-0]   0x818 - LSB byte (Input Mode)
#--------------------------------------------------------------

.data
	ID: .word 4,3,8,2,7,2,9,3
	IDSize: .word 8
	N: .word 0xB71B00
	IDSorted: .word 0:7
	
.text
main:	
	la $a0, ID
	lw $a1, IDSize
	la $a2, IDSorted
	jal sort

	lw  $t3,N
	add $t0, $zero, $zero
SHOW_ON_HEX0:
	add $t1, $zero, $t0
	sll $t1, $t1, 2
	add $t1, $t1, $a2
	lw $t2, 0($t1)
	sw $t2, 0x808
	addi $t0, $t0, 1  #$t0 -=1
	andi $t0, $t0, 7
	j delay

sort:
	
	#copy array
	add $t0, $zero, $a1 #$t0 = IDSize
	add $t1, $zero, $a0
	add $t2, $zero, $a2

loop1:
	beq $t0, $zero,endloop1
	lw $t4, 0($t1) # $t4 = M[$t1]
	sw $t4, 0($t2) # M[$t2] = $t4

	addi $t0, $t0, -1  #$t0 -=1
	addi $t1, $t1, 4    #$t1 +=4
	addi $t2, $t2, 4    #$t2 +=4
	j loop1
endloop1:
	#t0 i
	#t1 key
	#t2 j
	#t3 IDSize
	#t4 condition reg
	#t5 arr[j]
	addi $t0, $zero, 4				#t0 = 4
	add $t0, $t0, $a2
	add $t3, $zero, $a1				#t3 = IDSize
	sll $t3, $t3, 2			#t3 = 4*IDSize
	add $t3, $t3, $a2
	
for1:
	beq $t0, $t3, finishSort #if i == IDSize, jump finishsort
	lw $t1, 0($t0)		     #t1 = IDSorted[i] = key
	addi $t2, $t0, -4		 #t2 = i-1 = j
while1:	
	slt $t4, $t2, $a2		#if j < IDSorted set 0 else j >= IDSorted set 1
	bne $t4, $zero, afterw	#if j < 0 finish while
cont:	lw $t5, 0($t2)			#t5 = IDSorted[j]
	slt $t4, $t1, $t5		
	beq $t4, $zero, afterw	#if arr[j] < key finish while
	sw $t5, 4($t2)			#arr[j+1] = arr[j]
	addi $t2, $t2, -4		#j = j-1
	j while1
	
afterw:
	sw $t1, 4($t2)
	addi $t0, $t0, 4
	j for1	
	
finishSort: 
	jr $ra

	
delay:	move $t4, $zero # $t1=0
L:	addi $t4, $t4, 1  # $t1=$t1+1
	slt  $t5, $t4, $t3      #if $t1<N than $t2=1
	beq  $t5, $zero, SHOW_ON_HEX0   #if $t1>=N then go to Loop label
	j L 
	
	
