    ld b,c
    ld d,h
    ld (3632),a
    ld b,b
    ld c,64
    ld c,64
    ld b,d
    ld b,c
    ld b,d
    ld b,c
    inc e
    ld b,b
    rra 
    ld b,b
    ld sp,17728
    ld b,b
    sbc a,(hl)
    ld b,b
    jp nz,13888
    ld b,c
    nop
    nop
    ld b,1
    ld a,c
    ld b,b
    call p,16497
    call p,57833
    exx
    pop de
    ret 
    pop bc
    cp c
    or c
    rlca 
    dec l
    ld b,b
    ld bc,16505
    ret pe
    ld l,c
    ld b,b
    ret pe
    pop hl
    exx
    pop de
    ret 
    pop bc
    cp c
    or c
    xor c
    and c
    sbc a,c
    sub c
    adc a,c
    ld b,1
    sbc a,c
    sbc a,c
    sbc a,c
    sbc a,c
    sbc a,c
    sbc a,c
    and c
    and c
    and c
    and c
    ld sp,3136
    ld sp,3136
    ld sp,3136
    ld sp,3136
    ld sp,3136
    ld sp,3136
    ld sp,3136
    ld sp,3136
    ld sp,3136
    ld sp,3136
    ld sp,3136
    ld sp,3136
    ld b,c
    ld b,b
    inc bc
    ld b,c
    ld b,b
    inc bc
    ld b,c
    ld b,b
    inc bc
    ld b,c
    ld b,b
    inc bc
    ld b,c
    ld b,b
    inc bc
    ld b,c
    ld b,b
    inc bc
    ld b,c
    ld b,b
    inc bc
    ld c,c
    ld b,b
    rrca 
    ld c,c
    ld b,b
    dec b
    ld d,c
    ld b,b
    ld de,16489
    ex af,af'
    ld (hl),c
    ld b,b
    inc d
    ld sp,hl
    ld sp,hl
    ld sp,hl
    rlca 
    sbc a,b
    ld b,b
    ld bc,29177
    ld b,b
    call p,59889
    ld l,c
    ld b,b
    call p,57825
    exx
    exx
    pop de
    pop de
    ret 
    ret 
    pop bc
    pop bc
    cp c
    cp c
    or c
    or c
    xor c
    xor c
    and c
    and c
    sbc a,c
    sbc a,c
    sub c
    sub c
    adc a,c
    adc a,c
    nop
    ld b,1
    ld a,c
    ld b,b
    call p,16497
    call p,57833
    exx
    pop de
    ret 
    pop bc
    cp c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    or c
    cp c
    cp c
    cp c
    cp c
    pop bc
    pop bc
    pop bc
    pop bc
    pop bc
    pop bc
    ret 
    ret 
    ret 
    ret 
    ret 
    pop de
    pop de
    pop de
    pop de
    pop de
    pop de
    exx
    exx
    exx
    exx
    pop hl
    pop hl
    pop hl
    pop hl
    jp (hl)
    jp (hl)
    pop af
    pop af
    pop af
    pop af
    pop af
    pop af
    pop af
    ld sp,hl
    rlca 
    ld sp,3905
    and c
    xor c
    cp c
    pop bc
    ret 
    pop de
    exx
    jp (hl)
    pop af
    ld sp,hl
    ld b,2
    nop
    ld bc,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,bc
    ld a,(bc)
    ld e,l
    ld b,c
    sub e
    ld b,c
    sbc a,a
    ld b,c
    ld d,l
    ld b,c
    nop
    nop
    ld c,c
    ld b,c
    ld b,b
    nop
    nop
    nop
    rst 1
    ld b,c
    ret nc
    ld b,c
    xor e
    inc b
    ld a,(hl)
    xor (hl)
    ld (bc),a
    ld a,43
    inc a
    xor e
    inc b
    or b
    ld (bc),a
    inc a
    dec hl
    inc a
    add hl,hl
    inc a
    dec hl
    ld a,(hl)
    ld (43838),a
    inc b
    inc a
    xor e
    ld (bc),a
    inc sp
    inc a
    ld (11836),a
    inc a
    xor e
    inc b
    inc a
    or d
    ld (bc),a
    inc a
    scf
    inc a
    xor e
    inc b
    xor c
    ld (bc),a
    inc a
    add hl,hl
    ld h,60
    dec l
    inc a
    xor e
    ld b,61
    ld a,a
    add a,b
    nop
    dec a
    inc l
    xor e
    inc b
    dec a
    inc c
    xor h
    inc bc
    dec a
    ld a,a
    xor e
    inc b
    ld a,(hl)
    xor (hl)
    ld bc,11070
    inc a
    dec hl
    jr nc,$+62
    dec hl
    inc a
    add hl,hl
    inc a
    dec hl
    ld a,(hl)
    ld (11070),a
    inc a
    dec hl
    inc sp
    inc a
    ld (44604),a
    ld (bc),a
    inc a
    xor e
    ld bc,12860
    inc a
    scf
    inc a
    dec hl
    add hl,hl
    inc a
    add hl,hl
    ld h,60
    dec l
    inc a
    xor e
    dec b
    dec a
    ld a,a
    rst 7
    ld (bc),a
    dec d
    inc b
    ld bc,258
    inc b
    dec bc
    ld (bc),a
    ld bc,2820
    ld (bc),a
    ld bc,260
    ld (bc),a
    inc bc
    inc b
    ld bc,520
    ld bc,260
    ld (bc),a
    ld bc,6920
    nop
    ret p
    ld a,a
    jp PLY_AKG_INIT
    jp PLY_AKG_PLAY
    jp PLY_AKG_INITTABLE1_END
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_LSB-1
    add hl,de
    ld de,PLY_AKG_INSTRUMENTSTABLE+1
    ldi
    ldi
    inc hl
    inc hl
    add a,a
    ld e,a
    ld d,0
    add hl,de
    ld a,(hl)
    inc hl
    ld h,(hl)
    ld l,a
    ld de,PLY_AKG_BITFORNOISE
    add hl,de
    ld de,PLY_AKG_CHANNEL3_READCELLEND+1
    ldi
    ld de,PLY_AKG_CHANNEL1_NOTE+1
    ldi
    ld (PLY_AKG_READLINKER+1),hl
    ld hl,PLY_AKG_INITTABLE0
    ld bc,1792
    call PLY_AKG_INIT_READWORDSANDFILL
    inc c
    ld hl,PLY_AKG_INITTABLE0_END
    ld b,3
    call PLY_AKG_INIT_READWORDSANDFILL
    ld hl,PLY_AKG_INITTABLE1_END
    ld bc,439
    call PLY_AKG_INIT_READWORDSANDFILL
    ld hl,(PLY_AKG_INSTRUMENTSTABLE+1)
    ld e,(hl)
    inc hl
    ld d,(hl)
    ex de,hl
    inc hl
    ld (PLY_AKG_ENDWITHOUTLOOP+1),hl
    ld (PLY_AKG_CHANNEL1_PTINSTRUMENT+1),hl
    ld (PLY_AKG_CHANNEL2_PTINSTRUMENT+1),hl
    ld (PLY_AKG_CHANNEL3_PTINSTRUMENT+1),hl
    ret 
    ld e,(hl)
    inc hl
    ld d,(hl)
    inc hl
    ld a,c
    ld (de),a
    djnz $-6
    ret 
    inc sp
    ld b,h
    inc (hl)
    ld b,h
    ld b,h
    ld b,h
    ld b,l
    ld b,h
    ld d,l
    ld b,h
    ld d,(hl)
    ld b,h
    adc a,d
    ld b,d
    add a,h
    ld b,d
    ld (PLY_AKG_SAVESP+1),sp
    xor a
    ld l,a
    ld h,a
    ld (PLY_AKG_PSGREG8),a
    ld (PLY_AKG_PSGREG9),hl
    ld a,63
    jp PLY_AKG_SENDPSGREGISTERS
    ld (PLY_AKG_SAVESP+1),sp
    xor a
    ld (PLY_AKG_EVENT),a
    ld a,1
    dec a
    jp nz,PLY_AKG_SETSPEEDBEFOREPLAYSTREAMS
    ld a,1
    dec a
    jr nz,$+52
    ld sp,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    pop hl
    ld a,l
    or h
    jr nz,$+5
    pop hl
    ld sp,hl
    pop hl
    ld (PLY_AKG_CHANNEL1_READTRACK+1),hl
    pop hl
    ld (PLY_AKG_CHANNEL2_READTRACK+1),hl
    pop hl
    ld (PLY_AKG_CHANNEL3_READTRACK+1),hl
    pop hl
    ld (PLY_AKG_READLINKER+1),sp
    ld sp,hl
    pop hl
    ld c,l
    pop hl
    pop hl
    pop hl
    ld (PLY_AKG_EVENTTRACK_PTTRACK+1),hl
    xor a
    ld (PLY_AKG_READLINE+1),a
    ld (PLY_AKG_EVENTTRACK_END+1),a
    ld (PLY_AKG_CHANNEL1_READCELLEND+1),a
    ld (PLY_AKG_CHANNEL2_READCELLEND+1),a
    ld a,c
    ld (PLY_AKG_PATTERNDECREASINGHEIGHT+1),a
    ld a,0
    sub 1
    jr nc,$+22
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld a,(hl)
    inc hl
    srl a
    jr c,$+10
    jr nz,$+4
    ld a,(hl)
    inc hl
    ld (PLY_AKG_EVENT),a
    xor a
    ld (PLY_AKG_EVENTTRACK_PTTRACK+1),hl
    ld (PLY_AKG_READLINE+1),a
    ld a,0
    sub 1
    jr c,$+8
    ld (PLY_AKG_EVENTTRACK_END+1),a
    jp PLY_AKG_CHANNEL1_READCELLEND
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld c,(hl)
    inc hl
    ld a,c
    and 63
    cp 60
    jr c,$+44
    sub 60
    jp z,PLY_AKG_CHANNEL1_MAYBEEFFECTS
    dec a
    jr z,$+20
    dec a
    jr z,$+6
    ld a,(hl)
    inc hl
    jr $+31
    ld a,c
    rlca 
    rlca 
    and 3
    inc a
    ld (PLY_AKG_EVENTTRACK_END+1),a
    jr $+58
    ld a,(hl)
    ld (PLY_AKG_EVENTTRACK_END+1),a
    inc hl
    jr $+51
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld (PLY_AKG_CHANNEL1_PTINSTRUMENT+1),de
    jr $+36
    add a,0
    ld (PLY_AKG_CHANNEL1_TRACKNOTE+1),a
    rl c
    jr nc,$-16
    ld a,(hl)
    inc hl
    exx
    ld l,a
    ld h,0
    add hl,hl
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,de
    ld sp,hl
    pop hl
    ld a,(hl)
    inc hl
    ld (PLY_AKG_CHANNEL1_INSTRUMENTSPEED+1),a
    ld (PLY_AKG_CHANNEL1_PTINSTRUMENT+1),hl
    ld (PLY_AKG_CHANNEL1_SAMEINSTRUMENT+1),hl
    exx
    ex de,hl
    xor a
    ld (PLY_AKG_CHANNEL1_INSTRUMENTSTEP+2),a
    ex de,hl
    ld (PLY_AKG_CHANNEL1_READTRACK+1),hl
    ld a,0
    sub 1
    jr c,$+8
    ld (PLY_AKG_CHANNEL1_READCELLEND+1),a
    jp PLY_AKG_CHANNEL2_READCELLEND
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld c,(hl)
    inc hl
    ld a,c
    and 63
    cp 60
    jr c,$+44
    sub 60
    jp z,PLY_AKG_CHANNEL1_READEFFECTSEND
    dec a
    jr z,$+20
    dec a
    jr z,$+6
    ld a,(hl)
    inc hl
    jr $+34
    ld a,c
    rlca 
    rlca 
    and 3
    inc a
    ld (PLY_AKG_CHANNEL1_READCELLEND+1),a
    jr $+61
    ld a,(hl)
    ld (PLY_AKG_CHANNEL1_READCELLEND+1),a
    inc hl
    jr $+54
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld (PLY_AKG_CHANNEL2_PTINSTRUMENT+1),de
    jr $+39
    ld b,a
    ld a,(PLY_AKG_CHANNEL1_NOTE+1)
    add a,b
    ld (PLY_AKG_CHANNEL2_TRACKNOTE+1),a
    rl c
    jr nc,$-19
    ld a,(hl)
    inc hl
    exx
    ld e,a
    ld d,0
    ld hl,(PLY_AKG_INSTRUMENTSTABLE+1)
    add hl,de
    add hl,de
    ld sp,hl
    pop hl
    ld a,(hl)
    inc hl
    ld (PLY_AKG_CHANNEL2_INSTRUMENTSPEED+1),a
    ld (PLY_AKG_CHANNEL2_PTINSTRUMENT+1),hl
    ld (PLY_AKG_CHANNEL2_SAMEINSTRUMENT+1),hl
    exx
    ex de,hl
    xor a
    ld (PLY_AKG_CHANNEL2_INSTRUMENTSTEP+2),a
    ex de,hl
    ld (PLY_AKG_CHANNEL2_READTRACK+1),hl
    ld a,0
    sub 1
    jr c,$+8
    ld (PLY_AKG_CHANNEL2_READCELLEND+1),a
    jp PLY_AKG_CHANNEL3_READCELLEND
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld c,(hl)
    inc hl
    ld a,c
    and 63
    cp 60
    jr c,$+44
    sub 60
    jp z,PLY_AKG_CHANNEL2_READEFFECTSEND
    dec a
    jr z,$+20
    dec a
    jr z,$+6
    ld a,(hl)
    inc hl
    jr $+34
    ld a,c
    rlca 
    rlca 
    and 3
    inc a
    ld (PLY_AKG_CHANNEL2_READCELLEND+1),a
    jr $+61
    ld a,(hl)
    ld (PLY_AKG_CHANNEL2_READCELLEND+1),a
    inc hl
    jr $+54
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld (PLY_AKG_CHANNEL3_PTINSTRUMENT+1),de
    jr $+39
    ld b,a
    ld a,(PLY_AKG_CHANNEL1_NOTE+1)
    add a,b
    ld (PLY_AKG_CHANNEL3_TRACKNOTE+1),a
    rl c
    jr nc,$-19
    ld a,(hl)
    inc hl
    exx
    ld e,a
    ld d,0
    ld hl,(PLY_AKG_INSTRUMENTSTABLE+1)
    add hl,de
    add hl,de
    ld sp,hl
    pop hl
    ld a,(hl)
    inc hl
    ld (PLY_AKG_CHANNEL3_INSTRUMENTSPEED+1),a
    ld (PLY_AKG_CHANNEL3_PTINSTRUMENT+1),hl
    ld (PLY_AKG_CHANNEL3_SAMEINSTRUMENT+1),hl
    exx
    ex de,hl
    xor a
    ld (PLY_AKG_CHANNEL3_INSTRUMENTSTEP+2),a
    ex de,hl
    ld (PLY_AKG_CHANNEL3_READTRACK+1),hl
    ld a,0
    ld (PLY_AKG_TICKDECREASINGCOUNTER+1),a
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld a,h
    ld (PLY_AKG_CHANNEL1_GENERATEDCURRENTINVERTEDVOLUME+1),a
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,de
    ld (PLY_AKG_CHANNEL1_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS+1),hl
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld a,h
    ld (PLY_AKG_CHANNEL2_GENERATEDCURRENTINVERTEDVOLUME+1),a
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,de
    ld (PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS+1),hl
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld a,h
    ld (PLY_AKG_CHANNEL3_GENERATEDCURRENTINVERTEDVOLUME+1),a
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,de
    ld (PLY_AKG_CHANNEL3_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS+1),hl
    ld sp,(PLY_AKG_SAVESP+1)
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    exx
    db 253
    db 46
    db 0
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld de,57359
    call PLY_AKG_CHANNEL3_READEFFECTSEND
    db 253
    db 125
    inc a
    cp 0
    jr c,$+6
    ld (PLY_AKG_CHANNEL1_PTINSTRUMENT+1),hl
    xor a
    ld (PLY_AKG_CHANNEL1_INSTRUMENTSTEP+2),a
    ld a,e
    ld (PLY_AKG_PSGREG8),a
    srl d
    exx
    ld (PLY_AKG_PSGREG01_INSTR+1),hl
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    exx
    db 253
    db 46
    db 0
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld e,15
    nop
    call PLY_AKG_CHANNEL3_READEFFECTSEND
    db 253
    db 125
    inc a
    cp 0
    jr c,$+6
    ld (PLY_AKG_CHANNEL2_PTINSTRUMENT+1),hl
    xor a
    ld (PLY_AKG_CHANNEL2_INSTRUMENTSTEP+2),a
    ld a,e
    ld (PLY_AKG_PSGREG9),a
    srl d
    exx
    ld (PLY_AKG_PSGREG23_INSTR+1),hl
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    exx
    db 253
    db 46
    db 0
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld e,15
    nop
    call PLY_AKG_CHANNEL3_READEFFECTSEND
    db 253
    db 125
    inc a
    cp 0
    jr c,$+6
    ld (PLY_AKG_CHANNEL3_PTINSTRUMENT+1),hl
    xor a
    ld (PLY_AKG_CHANNEL3_INSTRUMENTSTEP+2),a
    ld a,e
    ld (PLY_AKG_PSGREG10),a
    ld a,d
    exx
    ld (PLY_AKG_PSGREG45_INSTR+1),hl
    ld bc,63104
    ld e,192
    out (c),e
    exx
    ld bc,62465
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    db 237
    db 113
    exx
    db 237
    db 113
    exx
    out (c),l
    exx
    out (c),c
    out (c),e
    exx
    out (c),c
    exx
    db 237
    db 113
    exx
    out (c),h
    exx
    out (c),c
    out (c),e
    exx
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    inc c
    out (c),c
    exx
    db 237
    db 113
    exx
    out (c),l
    exx
    out (c),c
    out (c),e
    exx
    inc c
    out (c),c
    exx
    db 237
    db 113
    exx
    out (c),h
    exx
    out (c),c
    out (c),e
    exx
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    inc c
    out (c),c
    exx
    db 237
    db 113
    exx
    out (c),l
    exx
    out (c),c
    out (c),e
    exx
    inc c
    out (c),c
    exx
    db 237
    db 113
    exx
    out (c),h
    exx
    out (c),c
    out (c),e
    exx
    ld h,0
    inc c
    inc c
    out (c),c
    exx
    db 237
    db 113
    exx
    out (c),a
    exx
    out (c),c
    out (c),e
    exx
    inc c
    out (c),c
    exx
    db 237
    db 113
    exx
    out (c),h
    exx
    out (c),c
    out (c),e
    exx
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    inc c
    out (c),c
    exx
    db 237
    db 113
    exx
    out (c),l
    exx
    out (c),c
    out (c),e
    exx
    inc c
    out (c),c
    exx
    db 237
    db 113
    exx
    out (c),h
    exx
    out (c),c
    out (c),e
    exx
    ld sp,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ret 
    ld (PLY_AKG_EVENTTRACK_END+1),a
    jp PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER
    ld (PLY_AKG_CHANNEL1_READCELLEND+1),a
    jp PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER
    ld (PLY_AKG_CHANNEL2_READCELLEND+1),a
    jp PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER
    ld a,(hl)
    inc hl
    ld b,a
    rra 
    jp c,PLY_AKG_S_OR_H_OR_SAH_OR_ENDWITHLOOP
    rra 
    jr c,$+43
    rra 
    and 15
    sub e
    jr nc,$+3
    xor a
    ld e,a
    set 2,d
    ret 
    and 15
    sub e
    jr nc,$+3
    xor a
    ld e,a
    rl b
    jr nc,$+6
    ld c,0
    jr $+5
    ld b,(hl)
    ld c,b
    inc hl
    call PLY_AKG_S_OR_H_CHECKIFSIMPLEFIRST_CALCULATEPERIOD
    ret 
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    inc hl
    xor a
    ld b,a
    jr $-38
    rra 
    jr $-9
    rra 
    jr c,$+6
    rra 
    jp nc,PLY_AKG_SOFT
    ld a,(hl)
    inc hl
    ld h,(hl)
    ld l,a
    jp PLY_AKG_CHANNEL3_READEFFECTSEND
    jr nc,$+22
    exx
    ex de,hl
    add hl,hl
    ld bc,PLY_AKG_PERIODTABLE
    add hl,bc
    ld a,(hl)
    inc hl
    ld h,(hl)
    ld l,a
    add hl,de
    exx
    rl b
    rl b
    rl b
    ret 
    rl b
    rl b
    jr nc,$+8
    ld a,(hl)
    inc hl
    exx
    add a,e
    ld e,a
    exx
    rl b
    exx
    ex de,hl
    add hl,hl
    ld bc,PLY_AKG_PERIODTABLE
    add hl,bc
    ld a,(hl)
    inc hl
    ld h,(hl)
    ld l,a
    add hl,de
    exx
    ret 
    nop
    xor 14
    jr $+16
    ld c,l
    dec c
    adc a,(hl)
    inc c
    jp c,12043
    dec bc
    adc a,a
    ld a,(bc)
    rst 6
    add hl,bc
    ld l,b
    add hl,bc
    pop hl
    ex af,af'
    ld h,c
    ex af,af'
    jp (hl)
    rlca 
    ld (hl),a
    rlca 
    inc c
    rlca 
    and a
    ld b,71
    ld b,237
    dec b
    sbc a,b
    dec b
    ld b,a
    dec b
    call m,46084
    inc b
    ld (hl),b
    inc b
    ld sp,62468
    inc bc
    cp h
    inc bc
    add a,(hl)
    inc bc
    ld d,e
    inc bc
    inc h
    inc bc
    or 2
    call z,41986
    ld (bc),a
    ld a,(hl)
    ld (bc),a
    ld e,d
    ld (bc),a
    jr c,$+4
    jr $+4
    jp m,56833
    ld bc,451
    xor d
    ld bc,402
    ld a,e
    ld bc,358
    ld d,d
    ld bc,319
    dec l
    ld bc,284
    inc c
    ld bc,253
    rst 5
    nop
    pop hl
    nop
    push de
    nop
    ret 
    nop
    cp (hl)
    nop
    or e
    nop
    xor c
    nop
    sbc a,a
    nop
    sub (hl)
    nop
    adc a,(hl)
    nop
    add a,(hl)
    nop
    ld a,a
    nop
    ld (hl),a
    nop
    ld (hl),c
    nop
    ld l,d
    nop
    ld h,h
    nop
    ld e,a
    nop
    ld e,c
    nop
    ld d,h
    nop
    ld d,b
    nop
    ld c,e
    nop
    ld b,a
    nop
    ld b,e
    nop
    ccf 
    nop
    inc a
    nop
    jr c,$+2
    dec (hl)
    nop
    ld (12032),a
    nop
    dec l
    nop
    ld hl,(10240)
    nop
    ld h,0
    inc h
    nop
    ld (8192),hl
    nop
    ld e,0
    inc e
    nop
    dec de
    nop
    add hl,de
    nop
    jr $+2
    ld d,0
    dec d
    nop
    inc d
    nop
    inc de
    nop
    ld (de),a
    nop
    ld de,4096
    nop
    rrca 
    nop
    ld c,0
    dec c
    nop
    dec c
    nop
    inc c
    nop
    dec bc
    nop
    dec bc
    nop
    ld a,(bc)
    nop
    add hl,bc
    nop
    add hl,bc
    nop
    ex af,af'
    nop
    ex af,af'
    nop
    rlca 
    nop
    rlca 
    nop
    rlca 
    nop
    ld b,0
    ld b,0
    ld b,0
    dec b
    nop
    dec b
    nop
    dec b
    nop
    inc b
    nop
    inc b
    nop
    inc b
    nop
    inc b
    nop
    inc b
    nop
    inc bc
    nop
    inc bc
    nop
    inc bc
    nop
    inc bc
    nop
    inc bc
    nop
    ld (bc),a
    nop
PLY_AKG_BITFORNOISE equ 5
PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER equ 17226
PLY_AKG_CHANNEL1_GENERATEDCURRENTINVERTEDVOLUME equ 17526
PLY_AKG_CHANNEL1_INSTRUMENTSPEED equ 17535
PLY_AKG_CHANNEL1_INSTRUMENTSTEP equ 17520
PLY_AKG_CHANNEL1_MAYBEEFFECTS equ 17819
PLY_AKG_CHANNEL1_NOTE equ 17186
PLY_AKG_CHANNEL1_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS equ 17513
PLY_AKG_CHANNEL1_PTINSTRUMENT equ 17523
PLY_AKG_CHANNEL1_READCELLEND equ 17229
PLY_AKG_CHANNEL1_READEFFECTSEND equ 17825
PLY_AKG_CHANNEL1_READTRACK equ 17132
PLY_AKG_CHANNEL1_SAMEINSTRUMENT equ 17177
PLY_AKG_CHANNEL1_TRACKNOTE equ 17516
PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER equ 17338
PLY_AKG_CHANNEL2_GENERATEDCURRENTINVERTEDVOLUME equ 17569
PLY_AKG_CHANNEL2_INSTRUMENTSPEED equ 17578
PLY_AKG_CHANNEL2_INSTRUMENTSTEP equ 17563
PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS equ 17556
PLY_AKG_CHANNEL2_PTINSTRUMENT equ 17566
PLY_AKG_CHANNEL2_READCELLEND equ 17341
PLY_AKG_CHANNEL2_READEFFECTSEND equ 17831
PLY_AKG_CHANNEL2_READTRACK equ 17241
PLY_AKG_CHANNEL2_SAMEINSTRUMENT equ 17286
PLY_AKG_CHANNEL2_TRACKNOTE equ 17559
PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER equ 17450
PLY_AKG_CHANNEL3_GENERATEDCURRENTINVERTEDVOLUME equ 17612
PLY_AKG_CHANNEL3_INSTRUMENTSPEED equ 17621
PLY_AKG_CHANNEL3_INSTRUMENTSTEP equ 17606
PLY_AKG_CHANNEL3_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS equ 17599
PLY_AKG_CHANNEL3_PTINSTRUMENT equ 17609
PLY_AKG_CHANNEL3_READCELLEND equ 17453
PLY_AKG_CHANNEL3_READEFFECTSEND equ 17837
PLY_AKG_CHANNEL3_READTRACK equ 17353
PLY_AKG_CHANNEL3_SAMEINSTRUMENT equ 17398
PLY_AKG_CHANNEL3_TRACKNOTE equ 17602
PLY_AKG_ENDWITHOUTLOOP equ 17880
PLY_AKG_EVENT equ 17955
PLY_AKG_EVENTTRACK_END equ 17120
PLY_AKG_EVENTTRACK_PTTRACK equ 17097
PLY_AKG_INIT equ 16889
PLY_AKG_INITTABLE0 equ 16985
PLY_AKG_INITTABLE0_END equ 16997
PLY_AKG_INITTABLE1_END equ 17001
PLY_AKG_INIT_READWORDSANDFILL equ 16982
PLY_AKG_INSTRUMENTSTABLE equ 17202
PLY_AKG_OPCODE_ADD_HL_BC_LSB equ 9
PLY_AKG_OPCODE_ADD_HL_BC_MSB equ 0
PLY_AKG_PATTERNDECREASINGHEIGHT equ 17033
PLY_AKG_PERIODTABLE equ 17956
PLY_AKG_PLAY equ 17019
PLY_AKG_PSGREG01_INSTR equ 17652
PLY_AKG_PSGREG10 equ 17784
PLY_AKG_PSGREG23_INSTR equ 17683
PLY_AKG_PSGREG45_INSTR equ 17716
PLY_AKG_PSGREG8 equ 17750
PLY_AKG_PSGREG9 equ 17783
PLY_AKG_READLINE equ 17091
PLY_AKG_READLINKER equ 17038
PLY_AKG_SAVESP equ 17815
PLY_AKG_SENDPSGREGISTERS equ 17641
PLY_AKG_SETSPEEDBEFOREPLAYSTREAMS equ 17455
PLY_AKG_SOFT equ 17858
PLY_AKG_S_OR_H_CHECKIFSIMPLEFIRST_CALCULATEPERIOD equ 17905
PLY_AKG_S_OR_H_OR_SAH_OR_ENDWITHLOOP equ 17891
PLY_AKG_TICKDECREASINGCOUNTER equ 17027
