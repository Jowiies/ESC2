.include "../../macros.s"
.include "../../crt0.s"

.data

ticks:  .word 0
end_c:  .byte 0
end_p:	.byte 0
arr_chr: .byte 'A', 'q', 'u', 'e', 's', 't', ' ', 'p', 'r', 'o', 'g', 'r', 'a', 'm', 'a', ' ', 'f', 'u', 'n', 'c', 'i', 'o', 'n', 'a'
        .balign 2
.text

main:
	$movei R0, interrupts_vector
	$movei R1, clock_ISR
	st 0(R0), R1
	$movei R1, printer_ISR
	st 7*2(R0), R1
	
	movi R0, 1
	out Rcon_rel, R0
	out Rcon_imp, R0
	ei
	
	$movei R5, arr_chr
for:
	ldb R0, 0(R5);
	bz R0, end_MAIN
	out Rdat_imp, R0
	$movei R0, 0x8001
	out Rcon_imp, R0

loop:	
	$movei R0, end_c
	ldb R1, 0(R0)
	bz R1, loop
	
	xor R1, R1, R1
	stb 0(R0), R1
	addi R5, R5, 1
	bnz R0, for
end_MAIN:
	halt

printer_ISR:
	;The character has been printed
	in R0, Rest_imp	
	$movei R1, end_p	
	stb 0(R1), R0
	jmp R6

clock_ISR:
	; ticks++
	$movei R0, ticks
	ld R1, 0(R0)
	addi R1, R1, 1
	st 0(R0), R1
	
	; if (!printer_ready) return
	$movei R0, end_p
	ldb R0, 0(R0)
	bz R0, end_CLK

	; if (ticks < 10) return
	movi R2, 10
	$cmpge R2, R1, R2
	bz R2, end_CLK

	; ticks = 0
	movi R1, 0
	$movei R0, ticks
	st 0(R0), R1

	; clock_ready = true
	addi R1, R1, 1
	$movei R0, end_c
	stb 0(R0), R1

	; printer_ready = false
	$movei R0, end_p
	xor R1, R1, R1 
	stb 0(R0), R1
end_CLK:
	jmp R6
