.include "../../macros.s"
.include "../../crt0.s"

.text

main:
        movi R1, 4          ; fila
        movi R2, 8          ; columna
        out Rfil_pant, R1
        out Rcol_pant, R2
        
        movi R0, 0
        out Rcon_tec, R0    ;sync keyboard

do:     in R1, Rest_tec
        bz R1, do

        $movei R0, 0x100 + 'A
        $movei R1 0x8000
        out Rdat_pant, R0
        out Rcon_pant, R1

halt
