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

	$movei R2, Y
	add R2, R2, R0
	add R2, R2, R0
	
	ld R1, 0(R1)
	ld R2, 0(R2)

	add R1, R1, R2		

	$movei R2, Z
	add R2, R2, R0
	add R2, R2, R0
	st 0(R2), R1

	addi R0, R0, 1

	bnz R0, for

end_for:
	halt
