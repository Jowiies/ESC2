.include "../../macros.s"
.include "../../crt0.s"

.data

end:	.byte 0
key:	.byte 0
		.balign 2

.text

main:
	;setting interrupt vector with our ISR
	$movei R0, interrupts_vector
	$movei R1, keyboard_ISR
	st 1*2(R0), R1		;vector[keyboard ID] = keyboard_ISR

	;connecting with interrupt to the keyboard
	movi R0, 1
	out Rcon_tec, R0
	ei
	
loop:
	$movei R0, end
	ldb R2, 0(R0)
	bz R2, loop
	
	$movei R0, key
	ldb R0, 0(R0)
	$movei R1, 'X
	cmpeq R1, R1, R0
	bnz R1, end_MAIN	;if (key == X) break

	;Setting screen position
	movi R1, 4
	out Rfil_pant, R1
	movi R1, 8
	out Rcol_pant, R1
	
	;Setting key character + inverse mode
	$movei R0, key
	ldb R0, 0(R0)
	$movei R1, 0x100
	add R1, R1, R0
	out Rdat_pant, R1

	;Connection to the Screen
	$movei R0, 0x8000
	out Rcon_pant, R0
	
	xor R0, R0, R0
	bz R0, loop
end_MAIN:
	halt

keyboard_ISR:
	;reading the input from the keyboard
	$movei R0, tteclat
	in R1, Rdat_tec
	add R0, R1, R0		
	ldb R0, 0(R0)
	$movei R1, key
	stb 0(R1), R0		;key = tteclat[Rdat_tec]
	
	;keypressed = true
	$movei R0, end
	movi R1, 1			
	stb 0(R0), R1

	jmp R6
