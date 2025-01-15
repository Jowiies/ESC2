.include "../macros.s"
.include "../crt0.s"

.data
frase:	.asciz "Bon any nou 2025"
.balign 2

.text

main:
	$movei R0, frase
	
	movi R2, 4
	out Rfil_pant, R2

	xor R2, R2, R2
	$movei R3, 0x8000

while:
	ldb R1, 0(R0)
	bz R1, end_main

	out Rcol_pant, R2
	out Rdat_pant, R1

	out Rcon_pant, R3

	addi R0, R0, 1
	addi R2, R2, 1
	
	bnz R0, while

end_main:
	halt
