.include "../macros.s"
.include "../crt0.s"

.text

main:
        $movei R3 0x8000
        movi R1, 4          ; fila
        movi R2, 8          ; columna
        out Rfil_pant, R1
        out Rcol_pant, R2
        $movei R1, 0x100 + 'A
        out Rdat_pant, R1
        out Rcon_pant, R3

        addi R2, R2, 1
        out Rcol_pant, R2
        $movei R1, 'B
        out Rdat_pant, R1
        out Rcon_pant, R3

halt

            
