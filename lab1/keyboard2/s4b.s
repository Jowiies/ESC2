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

do:     in R0, Rest_tec
        bz R0, do

        $movei R0, tteclat
        in R1, Rdat_tec
        add R1, R0, R1
        ldb R0, 0(R1)

        $movei R1 0x100
        add R0, R1, R0
        
        $movei R1 0x8000

        out Rdat_pant, R0
        out Rcon_pant, R1
halt
