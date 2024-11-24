### Definicions internes del modul. No haurien d'usar-se ###
#
#


.macro $__push3 argnum p1 p2 p3 p4 p5 p6 p7 p8 p9
.if (\argnum)>0
	.ifnc \p1,void
		st [\argnum-1]*2(r7), \p1
                $__push3 \argnum-1 \p2 \p3 \p4 \p5 \p6 \p7 \p8 \p9 void
        .else
		$__push3 \argnum \p2 \p3 \p4 \p5 \p6 \p7 \p8 \p9 void
	.endif
.endif
.endm

.macro $__pushf3 argnum p1 p2 p3 p4 p5 p6 p7 p8 p9
.if (\argnum)>0
	.ifnc \p1,void
		stf [\argnum-1]*2(r7), \p1
                $__pushf3 \argnum-1 \p2 \p3 \p4 \p5 \p6 \p7 \p8 \p9 void
        .else
		$__pushf3 \argnum \p2 \p3 \p4 \p5 \p6 \p7 \p8 \p9 void
	.endif
.endif
.endm

.macro $__push2 argnum p1 p2 p3 p4 p5 p6 p7 p8 p9
    .ifnc \p1,void
	$__push2 \argnum+1 \p2 \p3 \p4 \p5 \p6 \p7 \p8 \p9 \p1
    .elseif (\argnum)==0
	.fail 100
    .else
	addi r7, r7, -(\argnum)*2
	$__push3 \argnum \p1 \p2 \p3 \p4 \p5 \p6 \p7 \p8 \p9
    .endif
.endm

.macro $__pushf2 argnum p1 p2 p3 p4 p5 p6 p7 p8 p9
    .ifnc \p1,void
	$__pushf2 \argnum+1 \p2 \p3 \p4 \p5 \p6 \p7 \p8 \p9 \p1
    .elseif (\argnum)==0
	.fail 100
    .else
	addi r7, r7, -(\argnum)*2
	$__pushf3 \argnum \p1 \p2 \p3 \p4 \p5 \p6 \p7 \p8 \p9
    .endif
.endm

.macro $__pop2 argnum p1 p2 p3 p4 p5 p6 p7 p8
    .ifnc \p1,void
	ld	\p1, [\argnum]*2(r7)
	$__pop2	\argnum+1 \p2 \p3 \p4 \p5 \p6 \p7 \p8 void
    .elseif (\argnum)==0
	.fail 100
    .else
	addi	r7, r7, [\argnum]*2(r7)
    .endif
.endm

.macro $__popf2 argnum p1 p2 p3 p4 p5 p6 p7 p8
    .ifnc \p1,void
	ldf	\p1, [\argnum]*2(r7)
	$__popf2 \argnum+1 \p2 \p3 \p4 \p5 \p6 \p7 \p8 void
    .elseif (\argnum)==0
	.fail 100
    .else
	addi	r7, r7, [\argnum]*2(r7)
    .endif
.endm

### Macros definides per a l'us dels alumnes ###
#
#

.macro $push p1=void p2=void p3=void p4=void p5=void p6=void p7=void p8=void
	$__push2 0 \p1 \p2 \p3 \p4 \p5 \p6 \p7 \p8 void
.endm

.macro $pop p1=void p2=void p3=void p4=void p5=void p6=void p7=void p8=void
	$__pop2 0 \p1 \p2 \p3 \p4 \p5 \p6 \p7 \p8
.endm

.macro $pushf p1=void p2=void p3=void p4=void p5=void p6=void p7=void p8=void
	$__pushf2 0 \p1 \p2 \p3 \p4 \p5 \p6 \p7 \p8 void
.endm

.macro $popf p1=void p2=void p3=void p4=void p5=void p6=void p7=void p8=void
	$__popf2 0 \p1 \p2 \p3 \p4 \p5 \p6 \p7 \p8
.endm

.macro $movei p1 imm16
	movi	\p1, lo(\imm16)
	movhi	\p1, hi(\imm16)
.endm

.macro $call p1 p2
        $movei	\p1 \p2
	jal	\p1, \p1
.endm

.macro $CMPLT p1 p2 p3
	CMPLT	\p1, \p2, \p3
.endm

.macro $CMPLE p1 p2 p3
	CMPLE	\p1, \p2, \p3
.endm

.macro $CMPGT p1 p2 p3
	CMPLT	\p1, \p3, \p2
.endm

.macro $CMPGE p1 p2 p3
	CMPLE	\p1, \p3, \p2
.endm

.macro $CMPEQ p1 p2 p3
	CMPEQ	\p1, \p2, \p3
.endm

.macro $CMPNE p1 p2 p3
	CMPEQ	\p1, \p2, \p3
	NOT	\p1,\p1
	ADDI 	\p1,\p1,2
.endm

.macro $CMPLTU p1 p2 p3
	CMPLTU	\p1, \p2, \p3
.endm

.macro $CMPLEU p1 p2 p3
	CMPLEU	\p1, \p2, \p3
.endm

.macro $CMPGTU p1 p2 p3
	CMPLTU	\p1, \p3, \p2
.endm

.macro $CMPGEU p1 p2 p3
	CMPLEU	\p1, \p3, \p2
.endm

.macro $CMPEQU p1 p2 p3
	CMPEQ	\p1, \p2, \p3
.endm

.macro $CMPNEU p1 p2 p3
        $CMPNE \p1 \p2 \p3
.endm

.macro $CMPLTF p1 p2 p3
	CMPLTF	\p1, \p2, \p3
.endm

.macro $CMPLEF p1 p2 p3
	CMPLEF	\p1, \p2, \p3
.endm

.macro $CMPGTF p1 p2 p3
	CMPLTF	\p1, \p3, \p2
.endm

.macro $CMPGEF p1 p2 p3
	CMPLEF	\p1, \p3, \p2
.endm

.macro $CMPEQF p1 p2 p3
	CMPEQF	\p1, \p2, \p3
.endm

.macro $CMPNEF p1 p2 p3
	CMPEQF	\p1, \p2, \p3
	NOT 	\p1,\p1
	ADDI	\p1,\p1,2
.endm
