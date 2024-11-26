.include "../../macros.s"
.include "../../crt0.s"

.data

move:	.byte 0
key:	.byte 0
ticks:  .word 0

		.balign 2

.text

main:
	;adding ISRs to the interruption vector
	$movei R0, interrupts_vector
	$movei R1, clock_ISR
	st 0(R0), R1
	$movei R1, keyboard_ISR
	st 1*2(R0), R1

    ;setting row and column values
    movi R4, 4
    movi R5, 8
	
	;setting interruption connection
	movi R0, 1
	out Rcon_rel, R0
	out Rcon_tec, R0
	ei
    
    ;showing initial x
    $movei R1, 'X 
    out Rdat_pant, R1
    out Rfil_pant, R4
    out Rcol_pant, R5
    $movei R1, 0x8000
    out Rcon_pant, R1

for:
	$movei R0, key
	ldb R0, 0(R0)
	bz R0, for

	$movei R1, move
	ldb R2, 0(R1)
    bz R2, show
    
    ;move = false
    xor R2, R2, R2
    stb 0(R1), R2

	; ticks = 0
	$movei R1, ticks
	st 0(R1), R2
    
    ;Clean char from screen
    $movei R1, ' 
    out Rdat_pant, R1
    out Rfil_pant, R4
    out Rcol_pant, R5
    $movei R1, 0x8000
    out Rcon_pant, R1
    
    ;if(key == 'P') --row
    $movei R1, 'P
    cmpeq R1, R0, R1
    sub R4, R4, R1
    
    ;if(key == 'L') ++row
    $movei R1, 'L
    cmpeq R1, R0, R1
    add R4, R4, R1

    ;if(key == 'S') ++cloumn
    $movei R1, 'S
    cmpeq R1, R0, R1
    add R5, R5, R1

    ;if(key == 'A') --column
    $movei R1, 'A
    cmpeq R1, R0, R1
    sub R5, R5, R1

    ;check if the positions are out of bounds
    xor R0, R0, R0
    xor R1, R1, R1

    cmplt R2, R4, R0
    or R1, R1, R2

    cmplt R2, R5, R0
    or R1, R1, R2

    addi R0, R0, 16
    cmple R2, R0, R4
    or R1, R1, R2

    add R0, R0, R0
    add R0, R0, R0

    cmple R2, R0, R5
    or R1, R1, R2

    bnz R1, end_MAIN
show: 
    ;show in screen the X character
    $movei R1, 'X 
    out Rdat_pant, R1
    out Rfil_pant, R4
    out Rcol_pant, R5
    $movei R1, 0x8000
    out Rcon_pant, R1
    
    bnz R1, for

end_MAIN:   
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
	or R2, R2, R1
	$movei R1, 'L
	cmpeq R1, R0, R1
	or R2, R2, R1
	$movei R1, 'P
	cmpeq R1, R0, R1
	or R2, R2, R1	
	bz R2, end_KEYBOARD	

	;key = keyboar input
	$movei R1, key
	stb 0(R1), R0

	; ticks = 0
	movi R1, 0
	$movei R0, ticks
	st 0(R0), R1
end_KEYBOARD:
	jmp R6

clock_ISR:
	; ticks++
	$movei R0, ticks
	ld R1, 0(R0)
	addi R1, R1, 1
	st 0(R0), R1
	
	; if (ticks >= 4) return
	movi R2, 4
	$cmpge R2, R1, R2
	bz R2, end_CLK

	; move = true
	addi R1, R1, 1
	$movei R0, move
	stb 0(R0), R1
end_CLK:
	jmp R6

	
