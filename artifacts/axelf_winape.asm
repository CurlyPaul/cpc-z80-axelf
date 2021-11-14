    ld b,c
    ld d,h
    ld (3632),a
    ld b,b
    ld c,64
    ld c,64
    ld b,h
    ld b,b
    ld c,c
    ld b,b
    ld d,64
    add hl,de
    ld b,b
    ld h,64
    dec (hl)
    ld b,b
    nop
    nop
    ld b,3
    ld sp,hl
    pop af
    jp (hl)
    pop hl
    exx
    pop de
    ret 
    pop bc
    cp c
    or c
    xor c
    ld b,15
    nop
    sub c
    sbc a,c
    and c
    xor c
    cp c
    pop bc
    ret 
    pop de
    exx
    jp (hl)
    pop af
    pop af
    ld b,3
    ld a,c
    ld b,b
    inc c
    pop af
    jp (hl)
    pop hl
    exx
    pop de
    ret 
    pop bc
    cp c
    or c
    xor c
    ld b,70
    ld b,b
    ld c,176
    or 2
    nop
    ld bc,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,bc
    ld a,(bc)
    ld h,h
    ld b,b
    sbc a,e
    ld b,b
    and h
    ld b,b
    ld e,h
    ld b,b
    nop
    nop
    ld d,b
    ld b,b
    ld b,b
    nop
    nop
    nop
    and (hl)
    ld b,b
    and a
    ld b,b
    xor e
    inc bc
    ld a,(hl)
    xor (hl)
    ld bc,43838
    inc bc
    inc a
    xor e
    ld bc,15408
    xor e
    inc bc
    inc a
    xor c
    ld bc,43836
    inc bc
    ld a,(hl)
    or d
    ld bc,11070
    inc a
    dec hl
    inc sp
    inc a
    ld (11836),a
    inc a
    dec hl
    inc a
    ld (14140),a
    inc a
    dec hl
    add hl,hl
    inc a
    add hl,hl
    ld h,60
    dec l
    inc a
    dec hl
    dec a
    dec b
    ld a,h
    nop
    dec a
    ld a,a
    inc a
    add a,b
    nop
    dec a
    jr nc,$-82
    ld (bc),a
    dec a
    ld a,a
    dec a
    ld a,a
    rst 7
    rst 7
    jp PLY_AKG_INIT
    jp PLY_AKG_PLAY
    jp PLY_AKG_INITTABLEORA_END
    ld de,PLY_AKG_BITFORSOUND+2
    add hl,de
    inc hl
    inc hl
    inc hl
    inc hl
    ld de,PLY_AKG_INSTRUMENTSTABLE+1
    ldi
    ldi
    ld c,(hl)
    inc hl
    ld b,(hl)
    inc hl
    ld (PLY_AKG_CHANNEL_READEFFECTS_EFFECTBLOCKS1+1),bc
    ld (PLY_AKG_CHANNEL_READEFFECTS_EFFECTBLOCKS2+1),bc
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
    ld bc,1207
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
    call po,58690
    ld b,d
    ld c,67
    rrca 
    ld b,e
    jr c,$+69
    add hl,sp
    ld b,e
    ld d,d
    ld b,c
    ld c,h
    ld b,c
    and 66
    djnz $+69
    ld a,(60739)
    ld (hl),e
    sub h
    ld b,h
    xor a
    ld l,a
    ld h,a
    ld (PLY_AKG_PSGREG8),a
    ld (PLY_AKG_PSGREG9),hl
    ld a,63
    jp PLY_AKG_SENDPSGREGISTERS
    ld (PLY_AKG_SAVESP+1),sp
    ld a,1
    dec a
    jp nz,PLY_AKG_SETSPEEDBEFOREPLAYSTREAMS
    ld a,1
    dec a
    jr nz,$+43
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
    xor a
    ld (PLY_AKG_READLINE+1),a
    ld (PLY_AKG_CHANNEL1_READCELLEND+1),a
    ld (PLY_AKG_CHANNEL2_READCELLEND+1),a
    ld a,c
    ld (PLY_AKG_PATTERNDECREASINGHEIGHT+1),a
    ld a,0
    sub 1
    jr c,$+8
    ld (PLY_AKG_READLINE+1),a
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
    ld (PLY_AKG_READLINE+1),a
    jr $+63
    ld a,(hl)
    ld (PLY_AKG_READLINE+1),a
    inc hl
    jr $+56
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
    rl c
    jp c,PLY_AKG_CHANNEL1_READEFFECTS
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
    jr $+66
    ld a,(hl)
    ld (PLY_AKG_CHANNEL1_READCELLEND+1),a
    inc hl
    jr $+59
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
    rl c
    jp c,PLY_AKG_CHANNEL2_READEFFECTS
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
    jr $+66
    ld a,(hl)
    ld (PLY_AKG_CHANNEL2_READCELLEND+1),a
    inc hl
    jr $+59
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
    rl c
    jp c,PLY_AKG_CHANNEL3_READEFFECTS
    ld (PLY_AKG_CHANNEL3_READTRACK+1),hl
    ld a,0
    ld (PLY_AKG_TICKDECREASINGCOUNTER+1),a
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    or a
    jr nc,$+24
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,de
    bit 7,h
    jr z,$+6
    ld h,0
    jr $+9
    ld a,h
    cp 16
    jr c,$+4
    ld h,15
    ld (PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGERANDDECIMAL+1),hl
    ld a,h
    ld (PLY_AKG_CHANNEL1_GENERATEDCURRENTINVERTEDVOLUME+1),a
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,de
    ld (PLY_AKG_CHANNEL1_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS+1),hl
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    or a
    jr nc,$+24
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,de
    bit 7,h
    jr z,$+6
    ld h,0
    jr $+9
    ld a,h
    cp 16
    jr c,$+4
    ld h,15
    ld (PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGERANDDECIMAL+1),hl
    ld a,h
    ld (PLY_AKG_CHANNEL2_GENERATEDCURRENTINVERTEDVOLUME+1),a
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,de
    ld (PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS+1),hl
    ld hl,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    or a
    jr nc,$+24
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,de
    bit 7,h
    jr z,$+6
    ld h,0
    jr $+9
    ld a,h
    cp 16
    jr c,$+4
    ld h,15
    ld (PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGERANDDECIMAL+1),hl
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
    call PLY_AKG_READINSTRUMENTCELL
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
    call PLY_AKG_READINSTRUMENTCELL
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
    call PLY_AKG_READINSTRUMENTCELL
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
    ld (PLY_AKG_READLINE+1),a
    bit 6,c
    jp z,PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER
    ld iy,PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS
    ld ix,PLY_AKG_CHANNEL1_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS
    ld de,PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER
    jr $+42
    ld (PLY_AKG_CHANNEL1_READCELLEND+1),a
    bit 6,c
    jp z,PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER
    ld iy,PLY_AKG_CHANNEL2_SOUNDSTREAM_RELATIVEMODIFIERADDRESS
    ld ix,PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS
    ld de,PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER
    jr $+21
    ld (PLY_AKG_CHANNEL2_READCELLEND+1),a
    bit 6,c
    jp z,PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER
    ld iy,PLY_AKG_CHANNEL3_SOUNDSTREAM_RELATIVEMODIFIERADDRESS
    ld ix,PLY_AKG_CHANNEL3_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS
    ld de,PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER
    ld (PLY_AKG_CHANNEL_READEFFECTS_ENDJUMP+1),de
    ex de,hl
    ld a,(de)
    inc de
    sla a
    jr c,$+39
    exx
    ld l,a
    ld h,0
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,de
    ld e,(hl)
    inc hl
    ld d,(hl)
    ld a,(de)
    inc de
    ld (PLY_AKG_CHANNEL_RE_EFFECTRETURN+1),a
    and 254
    ld l,a
    ld h,0
    ld sp,PLY_AKG_EFFECTTABLE
    add hl,sp
    ld sp,hl
    ret 
    ld a,0
    rra 
    jr c,$-19
    exx
    ex de,hl
    jp PLY_AKG_OPCODE_ADD_HL_BC_MSB
    srl a
    exx
    ld h,a
    exx
    ld a,(de)
    inc de
    exx
    ld l,a
    ld de,PLY_AKG_OPCODE_ADD_HL_BC_MSB
    add hl,de
    jr $-39
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
    call PLY_AKG_H_OR_ENDWITHLOOP
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
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    and h
    ld b,l
    or l
    ld b,l
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld a,(de)
    inc de
    ld (iy-31),a
    ld a,(de)
    inc de
    ld (iy-30),a
    ld (iy-35),55
    jp PLY_AKG_CHANNEL_RE_EFFECTRETURN
    ld (iy-35),183
    jp PLY_AKG_CHANNEL_RE_EFFECTRETURN
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
PLY_AKG_BITFORSOUND equ 2
PLY_AKG_CHANNEL1_BEFOREEND_STORECELLPOINTER equ 16881
PLY_AKG_CHANNEL1_GENERATEDCURRENTINVERTEDVOLUME equ 17266
PLY_AKG_CHANNEL1_INSTRUMENTSPEED equ 17275
PLY_AKG_CHANNEL1_INSTRUMENTSTEP equ 17260
PLY_AKG_CHANNEL1_INVERTEDVOLUMEINTEGERANDDECIMAL equ 17123
PLY_AKG_CHANNEL1_MAYBEEFFECTS equ 17559
PLY_AKG_CHANNEL1_NOTE equ 16836
PLY_AKG_CHANNEL1_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS equ 17253
PLY_AKG_CHANNEL1_PTINSTRUMENT equ 17263
PLY_AKG_CHANNEL1_READCELLEND equ 16884
PLY_AKG_CHANNEL1_READEFFECTS equ 17567
PLY_AKG_CHANNEL1_READEFFECTSEND equ 17580
PLY_AKG_CHANNEL1_READTRACK equ 16782
PLY_AKG_CHANNEL1_SAMEINSTRUMENT equ 16827
PLY_AKG_CHANNEL1_SOUNDSTREAM_RELATIVEMODIFIERADDRESS equ 17161
PLY_AKG_CHANNEL1_TRACKNOTE equ 17256
PLY_AKG_CHANNEL2_BEFOREEND_STORECELLPOINTER equ 16998
PLY_AKG_CHANNEL2_GENERATEDCURRENTINVERTEDVOLUME equ 17309
PLY_AKG_CHANNEL2_INSTRUMENTSPEED equ 17318
PLY_AKG_CHANNEL2_INSTRUMENTSTEP equ 17303
PLY_AKG_CHANNEL2_INVERTEDVOLUMEINTEGERANDDECIMAL equ 17165
PLY_AKG_CHANNEL2_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS equ 17296
PLY_AKG_CHANNEL2_PTINSTRUMENT equ 17306
PLY_AKG_CHANNEL2_READCELLEND equ 17001
PLY_AKG_CHANNEL2_READEFFECTS equ 17588
PLY_AKG_CHANNEL2_READEFFECTSEND equ 17601
PLY_AKG_CHANNEL2_READTRACK equ 16896
PLY_AKG_CHANNEL2_SAMEINSTRUMENT equ 16941
PLY_AKG_CHANNEL2_SOUNDSTREAM_RELATIVEMODIFIERADDRESS equ 17203
PLY_AKG_CHANNEL2_TRACKNOTE equ 17299
PLY_AKG_CHANNEL3_BEFOREEND_STORECELLPOINTER equ 17115
PLY_AKG_CHANNEL3_GENERATEDCURRENTINVERTEDVOLUME equ 17352
PLY_AKG_CHANNEL3_INSTRUMENTSPEED equ 17361
PLY_AKG_CHANNEL3_INSTRUMENTSTEP equ 17346
PLY_AKG_CHANNEL3_INVERTEDVOLUMEINTEGERANDDECIMAL equ 17207
PLY_AKG_CHANNEL3_PLAYINSTRUMENT_RELATIVEMODIFIERADDRESS equ 17339
PLY_AKG_CHANNEL3_PTINSTRUMENT equ 17349
PLY_AKG_CHANNEL3_READCELLEND equ 17118
PLY_AKG_CHANNEL3_READEFFECTS equ 17609
PLY_AKG_CHANNEL3_READTRACK equ 17013
PLY_AKG_CHANNEL3_SAMEINSTRUMENT equ 17058
PLY_AKG_CHANNEL3_SOUNDSTREAM_RELATIVEMODIFIERADDRESS equ 17245
PLY_AKG_CHANNEL3_TRACKNOTE equ 17342
PLY_AKG_CHANNEL_READEFFECTS_EFFECTBLOCKS1 equ 17635
PLY_AKG_CHANNEL_READEFFECTS_EFFECTBLOCKS2 equ 17677
PLY_AKG_CHANNEL_READEFFECTS_ENDJUMP equ 17665
PLY_AKG_CHANNEL_RE_EFFECTRETURN equ 17658
PLY_AKG_EFFECTTABLE equ 17794
PLY_AKG_ENDWITHOUTLOOP equ 17726
PLY_AKG_H_OR_ENDWITHLOOP equ 17744
PLY_AKG_INIT equ 16561
PLY_AKG_INITTABLE0 equ 16671
PLY_AKG_INITTABLE0_END equ 16683
PLY_AKG_INITTABLE1_END equ 16687
PLY_AKG_INITTABLEORA_END equ 16693
PLY_AKG_INIT_READWORDSANDFILL equ 16668
PLY_AKG_INSTRUMENTSTABLE equ 16852
PLY_AKG_OPCODE_ADD_HL_BC_MSB equ 0
PLY_AKG_PATTERNDECREASINGHEIGHT equ 16721
PLY_AKG_PERIODTABLE equ 17852
PLY_AKG_PLAY equ 16711
PLY_AKG_PSGREG01_INSTR equ 17392
PLY_AKG_PSGREG10 equ 17524
PLY_AKG_PSGREG23_INSTR equ 17423
PLY_AKG_PSGREG45_INSTR equ 17456
PLY_AKG_PSGREG8 equ 17490
PLY_AKG_PSGREG9 equ 17523
PLY_AKG_READINSTRUMENTCELL equ 17683
PLY_AKG_READLINE equ 16770
PLY_AKG_READLINKER equ 16726
PLY_AKG_SAVESP equ 17555
PLY_AKG_SENDPSGREGISTERS equ 17381
PLY_AKG_SETSPEEDBEFOREPLAYSTREAMS equ 17120
PLY_AKG_SOFT equ 17704
PLY_AKG_S_OR_H_OR_SAH_OR_ENDWITHLOOP equ 17737
PLY_AKG_TICKDECREASINGCOUNTER equ 16715
