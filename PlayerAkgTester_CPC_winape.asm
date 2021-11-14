        ;Tests the AKG player, for the AMSTRAD CPC.
        ;This compiles with RASM. Please check the compatibility page on the website, you can convert these sources to ANY assembler!

        ;Uncomment this to build a SNApshot, handy for testing (RASM feature).
        ;buildsna
        ;bankset 0

        org &1000
run Start
Start:

        di
        ld hl,&c9fb
        ld (&0038),hl

        ld hl,Music_Start
        xor a                   ;Subsong 0.
        call PLY_AKG_Init

        ld bc,&7f03
        out (c),c
        ld a,&4c
        out (c),a

Sync:   ld b,&f5
        in a,(c)
        rra
        jr nc,Sync + 2

        ei

        ;nop
        halt
        halt
        ;ld sp,&38

        ld b,90
        djnz $  	;; Effectively sets the speed by wasting 90*4 cycles

        ;Calls the player, shows some colors to see the consumed CPU.
        ld bc,&7f10
        out (c),c
        ld a,&4b
        out (c),a
        call PLY_AKG_Play
        ld bc,&7f10
        out (c),c
        ld a,&54
        out (c),a

        ;Endless loop!
        jr Sync
        

	org &4000
Music_Start:
        ;Include here the Player Configuration source of the songs (you can generate them with AT2 while exporting the songs).
        ;If you don't have any, the player will use a default Configuration (full code used), which may not be optimal.
        ;If you have several songs, include all their configuration here, their flags will stack up!
        ;Warning, this must be included BEFORE the player is compiled.
        ;include "./resources/axelf_playerconfig.asm"
        
        ;include "./resources/axelf.asm"
	read "./artifacts/axelf_winape.asm"
Music_End:
