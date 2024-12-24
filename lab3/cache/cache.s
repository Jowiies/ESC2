.include "../../macros.s"
.include "../../crt0.s"

.data
X:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
Y:	.word -2, 0, 3, 6, -2, 12, -3, 14, 5, 6
Z:	.space 20
	.balign 2

.text
	
main:
	xor R0, R0, R0

for:
	movi R1, 10
	cmplt R1, R0, R1
	bz R1, end_for
	
	$movei R1, X
	add R1, R1, R0
	add R1, R1, R0	
	movi R2, 15	

	$movei R6, show_line_cache
	jal R6, R6

	$movei R2, Y
	add R2, R2, R0
	add R2, R2, R0
	
	$push R1				;save @X[i] in the stack

	xor R1, R1, R1
	add R1, R2, R1
	movi R2, 30

	$movei R6, show_line_cache
	jal R6, R6

	$pop R2				;get @X[i] from the stack

	ld R1, 0(R1)
	ld R2, 0(R2)

	add R1, R1, R2		

	$movei R2, Z
	add R2, R2, R0
	add R2, R2, R0
	st 0(R2), R1

	xor R1, R1, R1
	add R1, R2, R1
	movi R2, 45
	
	$movei R6, show_line_cache
	jal R6, R6

	addi R0, R0, 1

	bnz R0, for

end_for:
	halt

;void show_line_cache(const int i, const word address, int col)
;R6 = return address	R0,R1,R2 = parameters
show_line_cache:
	movi R3, -3
	shl R3, R1, R3		;line

	$movei R4, 0x1ff	;bitmask in order to obtain 9 bits
	and R3, R3, R4		;line_cache

	; tag = address >> 12	(not necessary for this exercise)
	addi R4, R0, 4		;i + 4
	out Rfil_pant, R4

while:
	movi R4, 1
	and R4, R3, R4
	$movei R5, '0
	add R4, R4, R5

	out Rcol_pant, R2
	out Rdat_pant, R4
	$movei R4, 0x8000
	out Rcon_pant, R4

	movi R4, -1
	shl R3, R3, R4
	addi R2, R2, -1
	
	bnz R3, while

	jmp R6
