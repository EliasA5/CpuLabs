.data
	ID: .word 4,3,8,2,7,2,9,3
	IDSize: .word 8
	IDSorted: .word 0:7
	
.text
main:	
	nop
	la $a0, ID
	lw $a1, IDSize
	la $a2, IDSorted
	
	addi $a3, $a1, 4
	sw $a3, 0($a2)
	