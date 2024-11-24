.include "../../crt0.s"
.include "../../macros.s"

.data

end_c:	.byte 0
key:	.byte 0
		.balign 2

.text

main:
	;adding ISRs to the interruption vector
	$movei R0, interrupts_vector
	$movei R1, clock_ISR
	st 0(R0), R1

	$movei R1, keyboard_ISR
	st 1*2(R0), R1
	
	;setting interruption connection
	movi R0, 1
	out Rcon_rel, R0
	out Rcon_tec, R0
	ei

for:
	$movei R0, key
	ldb R0, 0(R0)
	bz R0, for

loop:	
	$movei R0, end_c
	ldb R1, 0(R0)
	bz R1, loop
	

	halt




keyboard_ISR:
	;getting keyboard input
	in R0, Rdat_tec
	$movei R1, tteclat
	add R0, R1, R0
	ldb R0, 0(R0)
	
	;discarding unwanted inputs
	$movei R1, 'A
	cmpeq R2, R0, R1
	$movei R1, 'S
	cmpeq R1, R0, R1
	and R2, R2, R1
	$movei R1, 'L
	cmpeq R1, R0, R1
	and R2, R2, R1
	$movei R1, 'P
	cmpeq R1, R0, R1
	and R2, R2, R1	
	bz R2, end_KEYBOARD	

	;key = keyboar input
	$movei R1, key
	stb 0(R1), R0
end_KEYBOARD:
	jmp R6

clock_ISR:
	; ticks++
	$movei R0, ticks
	ld R1, 0(R0)
	addi R1, R1, 1
	st 0(R0), R1
	
	; if (ticks < 4) return
	movi R2, 4
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
end_CLK:
	jmp R6

	
