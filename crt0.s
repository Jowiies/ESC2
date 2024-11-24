;
; Codi d'inicialitzacio que salta al main
; 

	; inicialitzem R0 i R7
	MOVI 	R0, 0		; R0  = 0
	MOVI	R7, 0		; R7  = 0

	; inicialitzem S5 i S7
	$MOVEI	R6, RSG
	WRS	S5, R6
	WRS	S7, R0		; I=0; V=0

	; cridem al main
	$CALL	R6, main
	HALT

;
; Vectors d'excepcions i d'interrupcions (16 posicions cada un)
;

exceptions_vector:
	.word	RSE_default_halt		; Instruccio il.legal
	.word	RSE_default_halt		; Acces a memoria no alineat
	.word	RSE_default_resume		; Overflow coma flotant
	.word	RSE_default_halt		; Div zero coma flotant
	.word	RSE_default_halt		; Div zero int/nat
	.word	RSE_default_halt		; reservat
	.word	RSE_default_halt		; reservat
	.word	RSE_default_halt		; reservat

interrupts_vector:
	.word	RSI_default_resume		; Rellotge
	.word	RSI_default_resume		; Teclat
	.word	RSI_default_resume
	.word	RSI_default_resume
	.word	RSI_default_resume
	.word	RSI_default_resume		; Disc
	.word	RSI_default_resume
	.word	RSI_default_resume		; Impressora

;
; Rutines especifiques d'excepcions i d'interrupcions
;

RSE_default_halt:
	HALT

RSE_default_resume:
	JMP	R6

RSI_default_resume:
	JMP	R6

;
; Rutina generica d'excepcions i d'interrupcions
;

RSG:
	$PUSH	R0, R1, R2, R3, R4, R5, R6
	$PUSHF	F0, F1, F2, F3, F4, F5, F6, F7
	RDS	R1, S0
	RDS	R2, S1
	RDS	R3, S3
	$PUSH	R1, R2, R3

	RDS	R1, S2
	MOVI	R2, 15
	$CMPLT	R3, R1, R2
	BZ	R3, __interrupcio
	$MOVEI	R2, exceptions_vector
	ADD	R1, R1, R1
        ADD     R2, R2, R1
	LD	R2, 0(R2)
	JAL	R6, R2
	BNZ	R6, __finRSG
__interrupcio:
	$MOVEI	R2, interrupts_vector
	GETIID	R1
	ADD	R1, R1, R1
	ADD	R2, R2, R1
	LD	R2, 0(R2)
	JAL	R6, R2
__finRSG:
	$POP	R3, R2, R1
	WRS	S3, R3
	WRS	S1, R2
	WRS	S0, R1
	$POPF	F7, F6, F5, F4, F3, F2, F1, F0
	$POP	R6, R5, R4, R3, R2, R1, R0
	RETI

;
; Adreces dels registres d'E/S, i geometria del disc
;

Rcon_rel	= 0x00

Rcon_pant	= 0x04
Rfil_pant	= 0x05
Rcol_pant	= 0x06
Rdat_pant	= 0x07

Rcon_tec	= 0x08
Rdat_tec	= 0x09
Rest_tec	= 0x0A

Rcon_imp	= 0x38
Rdat_imp	= 0x39
Rest_imp	= 0x3A

Rcara_disc	= 0x28
Rpist_disc	= 0x29
Rsect_disc	= 0x2A
Radr_disc	= 0x2B
Rcon_disc	= 0x2C
Rest_disc	= 0x2D

LONG_BLOC	= 1024
NUM_CARES       = 2
NUM_PISTES      = 4
NUM_SECTORS     = 16

;
; Taula de traduccio dels codis de rastreig del teclat
;

tteclat:
	.ascii	"1234567890\bQWERTYUIOP+ASDFGHJKL\nZXCVBNM,.- "
	.balign 2

