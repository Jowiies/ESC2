.include "../../macros.s"
.include "../../crt0.s"

.data

arr_chr: .byte 'A', 'q', 'u', 'e', 's', 't', ' ', 'p', 'r', 'o', 'g', 'r', 'a', 'm', 'a', ' ', 'f', 'u', 'n', 'c', 'i', 'o', 'n', 'a'

.balign 2

.text

main:
        $movei R1, arr_chr

        movi R0, 0
        out Rcon_imp, R0
        $movei R4, 0x8000

for:
        ldb R2, 0(R1)
        bz R2, end

do:
        in R5, Rest_imp
        bz R5, do
        
        out Rdat_imp, R2
        out Rcon_imp, R4
        addi R1, R1, 1
        bnz R1, for

end:
do_2:
        in R5, Rest_imp
        bz R5, do_2
halt
