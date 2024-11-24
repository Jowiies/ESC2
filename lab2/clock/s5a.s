.include "../../macros.s"
.include "../../crt0.s"

.data

ticks:  .word 0
end:    .byte 0
        .balign 2
.text

main:
	$movei R0, interrupts_vector
	$movei R1, clock
	st 0(R0), R1
	movi R2, 1
	out Rcon_rel, R2
	ei
	$movei R0, end
loop:
	ldb R2, 0(R0)
	bz R2, loop

	movi R1, 4
	out Rfil_pant, R1
	movi R1, 8
	out Rcol_pant, R1
	$movei R1, 'A
	out Rdat_pant, R1
	$movei R1, 0x8000
	out Rcon_pant, R1
	halt

clock:
	$movei R0, ticks
	ld R1, 0(R0)
	addi R1, R1, 1
	st 0(R0), R1
	movi R2, 5*10
	$cmpge R2, R1, R2
	bz R2, endCLK
	movi R1, 1
	$movei R0, end
	stb 0(R0), R1
endCLK:
	jmp R6

