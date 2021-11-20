        ;Tests the AKG player, for the AMSTRAD CPC.
        ;This compiles with RASM. Please check the compatibility page on the website, you can convert these sources to ANY assembler!

        ;Uncomment this to build a SNApshot, handy for testing (RASM feature).
        ;builds
        ;bankset 0

        org &1000
;write direct 'axelf.bin',&1000
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
	push de
	call DrawColumns
	pop de
	call IncrementEqualiser

	ld b,20		;; X
	ld c,100	;; Y
	call GetScreenPos;
	ld b,100	;; 100 lines tall
	push de
	call DrawColumns
	pop de
	call IncrementEqualiser

	ld b,48		;; X
	ld c,100	;; Y
	call GetScreenPos;
	ld b,100	;; 100 lines tall
	push de
	call DrawColumns
	pop de
	call IncrementEqualiser

        ;ld b,80
        ;djnz $  	;; Effectively sets the speed by wasting 90*4 cycles
	doMusic:
	push de
        ;Calls the player, shows some colors to see the consumed CPU.
        	call PLY_AKG_Play
	pop de
       
        jr Sync

IncrementEqualiser:
	inc ix
	ld e,(ix)
	ld a,e
	cp 0 
	jr nz,equaliserDone
		ld ix,Equaliser
		ld e,(ix)
	equaliserDone:
ret 
      
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

	ld b,e		;; B = the top line of the VU
	sra b		;; Half it as we are drawing two lines at a time

_drawRedLines:
	ld a,b
	sub 35		;; Red threshold/2
			;; A now holds the number of lines to draw in red
	jp m,_drawOrangeLines
	jr z,_drawOrangeLines
		;; Need to work out how many lines will be left after we've drawn the red ones *
		ld e,a		;; stash the no. red lines to draw in e for a while
		ld a,b		;; A = lines to draw
		sub e		;; A = lines to draw - lines in read
		ld b,a		;; B = lines to draw after red are drawn
		push bc		
			ld b,e	;; * becuase I need trash b here which is tracking the number of lines I will draw
			ld d,%11000000
			call DrawColouredLine
		pop bc
	
_drawOrangeLines:
		ld a,b
		sub 30		;; Orange threshold/2
				;; A now holds the number of lines to draw in orange
	jp m,_drawYellowLines
	jr z,_drawYellowLines 
		ld e,a		;; stash the no. orange lines to draw in e for a while
		ld a,b
		sub e
		ld b,a
		push bc
			ld b,e	
			ld d,%00001100
			call DrawColouredLine
		pop bc

_drawYellowLines:
		ld a,b
		sub 28		;; Yellow threshold/2
	jp m,_drawGreenLines
	jr z,_drawGreenLines 
		ld e,a		
		ld a,b
		sub e
		ld b,a
		push bc
			ld b,e	
			ld d,%11001100
			call DrawColouredLine
		pop bc

	_drawGreenLines:
		ld d,%00000000
		call drawColouredLine

ret

DrawColouredLine:
	;; INPUTS
	;; B = Number of lines to draw
	;; D = Byte to draw
	push bc		
		push hl		;; Preserve HL while we add the X values
			ld b,12
			drawMainColourRow:
				ld (hl),d
				inc hl
			djnz drawMainColourRow		
		pop hl		;; Return HL to the start of the row
		
		push de
			call GetNextLine
		pop de
		
		push hl
			ld b,12
			drawMainColourRowBlack:
				ld (hl),%11111111
				inc hl
			djnz drawMainColourRowBlack		
		pop hl
	
		push de		;; Need to preserve D as it has the palette colour in it
			call GetNextLine
		pop de
	pop bc	
	djnz DrawColouredLine
ret

align 2
Equaliser:	
	db 98,10,20,80,30,30,40,40,50,40,20,50,30,20,50,60,72,40,80,95,10,60,80,85,20,30,20,20,30,30,40,50,60,70,80,80,90,90,0

ScreenStartAddressFlag:	db 48  
ScreenOverflowAddress: 	dw &BFFF
BackBufferAddress: 	dw &8000 

read "./libs/CPC_V2_SimplePalette.asm"
read "./libs/CPC_SimpleScreenSetUp.asm"

;write direct 'music.bin',&4000
org &4000
Music_Start:
        ;Include here the Player Configuration source of the songs (you can generate them with AT2 while exporting the songs).
        ;If you don't have any, the player will use a default Configuration (full code used), which may not be optimal.
        ;If you have several songs, include all their configuration here, their flags will stack up!
        ;Warning, this must be included BEFORE the player is compiled.
        ;include "./resources/axelf_playerconfig.asm"
        
	read "./artifacts/axelf_winape.asm"
Music_End:
