.include "../../macros.s"
.include "../../crt0.s"

.data

w:      .word 0x4444

.balign 2

.text

main:
        movi R0, 0
        out Rcon_tec, R0    ;sync keyboard
        
        $movei R1, w
        ld R1, 0(R1)
       
        $call R6, show

while_true:
        $movei R1, w
        ld R1, 0(R1)
        
        in R0, Rest_tec
        bz R0, while_true
 
        $movei R0, tteclat
        in R2, Rdat_tec
        add R2, R0, R2
        ldb R0, 0(R2)

        movi R5, 1

        movi R3, 'A
        cmpeq R4, R3, R0
        bnz R4, if_ab
       
        movi R5, -1
        
        addi R3, R3, 1
        cmpeq R4, R3, R0
        bnz R4, if_ab

        addi R3, R3, 1
        cmpeq R4, R3, R0
        bnz R4, if_c

        movi R5, 2

        addi R3, R3, 1
        cmpeq R4, R3, R0
        bnz R4, if_d

        movi R3, '0
        cmplt R4, R0, R3
        bnz R4, while_show

        addi R3, R3, 9
        cmplt R4, R3, R0
        bnz R4, while_show

        movi R5, '0
        sub R0, R0, R5 
        movi R5, 1
        shl R0, R5, R0
        sub R0, R0, R5
        xor R1, R1, R0
        bz R4, while_show

if_ab:   
        shl R1, R1, R5
        bnz R4, while_show
if_c:
        sha R1, R1, R5
        bnz R4, while_show
if_d:
        div R1, R1, R5
        bnz R4, while_show

while_show:

        $call R6, show
        movi R0, 0
        bz R0, while_true
        

halt

show:
        movi R0, 0
        out Rfil_pant, R0
        addi R0, R0, 16
        $movei R4, 0x8000 
do:
        addi R0, R0, -1
        out Rcol_pant, R0
        
        movi R2, 0x1
        and R2, R1, R2
        $movei R3, 0x100 + '0
        add R2, R3, R2
        out Rdat_pant, R2

        out Rcon_pant, R4

        movi R2, -1
        shl R1, R1, R2
        
        bnz R0, do

        jmp R6


