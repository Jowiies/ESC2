.include "../macros.s"
.include "../crt0.s"

.data
frase1:	.asciz "Bon any nou 2025"
frase2: .asciz "Feliz 2025"
frase3: .asciz "Happy new year 2025"
frase4: .asciz "Bonne annee 2025"
frase5: .asciz "Boldog uj evet 2025"
error:	.asciz "Error: tecla no valida. Presiona: (1-5)."

key:	.byte 0
end:	.byte 0

	.balign 2

.text

main:
	
	;setting interrupt vector with custom ISR
	$movei R0, interrupts_vector
	$movei R1, keyboard_ISR
	st 1*2(R0), R1			;vector[keyboard ID] = keyboard_ISR
	
	;connecting via interruption to the keyboard
	movi R0, 1
	out Rcon_tec, R0
	ei

loop:
	$movei R0, end
	ldb R2, 0(R0)
	bz R2, loop

	$movei R0, key
	ldb R0, 0(R0)

	$movei R1, '0
	sub R1, R0, R1

	$movei R2, 1
	cmpeq R3, R1, R2
	bnz R3, opt1
	
	addi R2, R2, 1
	cmpeq R3, R1, R2
	bnz R3, opt2
		
	addi R2, R2, 1
	cmpeq R3, R1, R2
	bnz R3, opt3
	
	addi R2, R2, 1
	cmpeq R3, R1, R2
	bnz R3, opt4
	
	addi R2, R2, 1
	cmpeq R3, R1, R2
	bnz R3, opt5

	$movei R0, error
	bz R3, end_loop

	opt1:
		$movei R0, frase1
		bnz R3, end_loop
	opt2:
		$movei R0, frase2
		bnz R3, end_loop
	opt3:
		$movei R0, frase3
		bnz R3, end_loop
	opt4:
		$movei R0, frase4
		bnz R3, end_loop
	opt5:
		$movei R0, frase5

end_loop:
	
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
