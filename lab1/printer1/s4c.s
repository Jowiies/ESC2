.include "../../macros.s"
.include "../../crt0.s"

.text

main:
        movi R0, 0
        out Rcon_imp, R0
        $movei R4, 0x8000
do:
        in R5, Rest_imp
        bz R5, do

        movi R1, 0 + 'F
        out Rdat_imp, R1
        out Rcon_imp, R4

do_2:
        in R5, Rest_imp
        bz R5, do_2

        movi R1, 0 + 'I
        out Rdat_imp, R1
        out Rcon_imp, R4

final:
        in R5, Rest_imp
        bz R5, final

halt


