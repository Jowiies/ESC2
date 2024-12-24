.include "../../macros.s"
.include "../../crt0.s"

.text

main:
        movi R0, 4          ; fila
        out Rfil_pant, R0
        
        movi R0, 8          ; columna
        out Rcol_pant, R0
        
        movi R0, 0
        out Rcon_tec, R0    ;sync keyboard

        movi R2, 'F

do:     in R0, Rest_tec
        bz R0, do

        $movei R0, tteclat
        in R1, Rdat_tec
        add R1, R0, R1
        ldb R0, 0(R1)

        xor R3, R0, R2
        bz R3, end
        
		out Rdat_pant, R0
        
        $movei R1 0x8000
        out Rcon_pant, R1

        bnz R3, do

end:
        halt
