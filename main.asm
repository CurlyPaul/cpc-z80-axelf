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

        ld hl,Music_Start
        xor a                   ;Subsong 0.
        call PLY_AKG_Init

	
	call Palette_Init
        ei
	call ClearScreen
	call SwitchScreenBuffer
	call ClearScreen

	ld ix,Equaliser

Sync:   ld b,&f5
        in a,(c)
        rra
        jr nc,Sync + 2
	
	call ClearScreen
	ld bc,&1500
	ld d,%11110000
	call DrawColumns
	inc ix
	call SwitchScreenBuffer

        ;ld b,80
        ;djnz $  	;; Effectively sets the speed by wasting 90*4 cycles

        ;Calls the player, shows some colors to see the consumed CPU.
        call PLY_AKG_Play

        ;Endless loop!
        jr Sync

ClearArea:
	;; INPUTS
	;; BC = X Y
	;; IX = Lines to clear
       
DrawColumns:
	;; INPUTS
	;; BC = XY
	;; IX = Address of Number of lines
	;; D = Palette index
	call GetScreenPos;

	ld b,(ix)
	
	ld a,b
	cp 0 
	jr nz,drawLine
		ld ix,Equaliser
		inc ix
		ld b,(ix)
	drawLine:
		push bc
		push hl
			ld b,25
			drawRow:
				ld a,%11110000
				ld (hl),d
				inc hl
			djnz drawRow		
		pop hl
		pop bc
		push de
			call GetNextLine
		pop de
		djnz DrawLine
ret


align 2
Equaliser:	;; Y Coord of where the top of the column arrives
	db 100,180,170,10,80,90,0

ScreenStartAddressFlag:	db 48  
ScreenOverflowAddress: 	dw &BFFF
BackBufferAddress: 	dw &8000 

read "./libs/CPC_V1_SimplePalette.asm"
read "./libs/CPC_V1_SimpleScreenSetUp.asm"

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
