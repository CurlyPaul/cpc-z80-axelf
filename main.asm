        ;Tests the AKG player, for the AMSTRAD CPC.
        ;This compiles with RASM. Please check the compatibility page on the website, you can convert these sources to ANY assembler!

        ;Uncomment this to build a SNApshot, handy for testing (RASM feature).
        ;buildsna
        ;bankset 0

        org &1000
run Start
Start:

	ld a,0
	call &BC0E	; scr_set_mode 0 - 16 colors
	

        di
        ld hl,&c9fb
        ld (&0038),hl

	ld sp,&3fff
	ei
	
        ld hl,Music_Start
        xor a                   ;Subsong 0.
        call PLY_AKG_Init

	call Palette_AllBackground
	call ClearScreen

Sync1:   ld b,&f5
        in a,(c)
        rra
        jr nc,Sync1 + 2

	call SwitchScreenBuffer
	call ClearScreen

	call Palette_Init

	ld ix,Equaliser
	ld e,(ix)

Sync:   ld b,&f5
        in a,(c)
        rra
        jr nc,Sync + 2
	
	call SwitchScreenBuffer	

	ld b,34		;; X
	ld c,100	;; Y
	call GetScreenPos;
	ld b,100	;; 100 lines tall
	call DrawColumns

	inc ix
	ld e,(ix)
	ld a,e
	cp 0 
	jr nz,doMusic
		ld ix,Equaliser
		ld e,(ix)

        ;ld b,80
        ;djnz $  	;; Effectively sets the speed by wasting 90*4 cycles
	doMusic:
	push de
        ;Calls the player, shows some colors to see the consumed CPU.
        	call PLY_AKG_Play
	pop de
       
        jr Sync
       
DrawColumns:
	;; INPUTS
	;; HL = Starting screen address -> Mutates, has coord of the last line
	;; E = Top of the VU
	;; B = Total number of lines

	push bc

	ld a,b
	sub e
	ld b,a
	
	drawBackgroundLine:
		push bc
		push hl
			ld b,12
			drawBackgroundRow:
				ld (hl),%11111111
				inc hl
			djnz drawBackgroundRow		
		pop hl
		pop bc
		push de
			call GetNextLine
		pop de
		djnz drawBackgroundLine

	pop bc

	ld b,e

	drawMainColourLine:
		push bc
		push hl
			ld b,12
			drawMainColourRow:
				ld (hl),%00000000
				inc hl
			djnz drawMainColourRow		
		pop hl
		pop bc
		push de
			call GetNextLine
		pop de
		djnz drawMainColourLine

ret


align 2
Equaliser:	
	db 10,20,30,40,40,40,40,10,5,10,20,50,60,70,80,90,10,10,10,10,20,20,20,20,30,30,40,50,60,70,80,80,90,90,0

ScreenStartAddressFlag:	db 48  
ScreenOverflowAddress: 	dw &BFFF
BackBufferAddress: 	dw &8000 

read "./libs/CPC_V2_SimplePalette.asm"
read "./libs/CPC_SimpleScreenSetUp.asm"

	org &4000
Music_Start:
        ;Include here the Player Configuration source of the songs (you can generate them with AT2 while exporting the songs).
        ;If you don't have any, the player will use a default Configuration (full code used), which may not be optimal.
        ;If you have several songs, include all their configuration here, their flags will stack up!
        ;Warning, this must be included BEFORE the player is compiled.
        ;include "./resources/axelf_playerconfig.asm"
        
	read "./artifacts/axelf_winape.asm"
Music_End:
