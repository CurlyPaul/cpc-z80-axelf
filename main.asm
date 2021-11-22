        ;Tests the AKG player, for the AMSTRAD CPC.
        ;This compiles with RASM. Please check the compatibility page on the website, you can convert these sources to ANY assembler!

        ;Uncomment this to build a SNApshot, handy for testing (RASM feature).
        ;builds
        ;bankset 0

        org &1000
;write direct 'axelf.bin',&1000
debug equ 1
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

SyncForScreenSetUp:   ld b,&f5
        in a,(c)
        rra
        jr nc,SyncForScreenSetUp + 2

	call SwitchScreenBuffer
	call ClearScreen

	call Palette_Init

	ld ix,Equaliser
	ld iy,ScreenDrawTable
	ld e,(ix)

Sync:   ld b,&f5
        in a,(c)
        rra
        jr nc,Sync + 2

	call SwitchScreenBuffer	

	;; a jump table would mean reducing a into descrete values
	;; if I use a descreasing ticker
	;; when the ticker reaches zero
	;; increment a pointer to 

	ld a,(&414c)	;; PLY_AKG_TICKDECREASINGCOUNTER but defined in a way winape doesn't get	
	cp a,1
	jr nz,@doDrawing
		;; decrement our slow ticker
		ld a,(ScreenIndexCountdown)
		dec a
		jr nz,@saveIndexAndDoDrawing
			inc iy
			inc iy
			inc iy
			ld a,(iy)
			cp a,0
			jr nz,@resetCountdownAndChangeScreen
				ld iy,ScreenDrawTable	;; Reset the screen script to the start
			@resetCountdownAndChangeScreen
			ld h,(iy+1)
			ld l,a
			ld (JumpDrawRountine-2),hl

			ld a,(iy+2)
			
	@saveIndexAndDoDrawing
		ld (ScreenIndexCountdown),a
	@doDrawing:
	push iy
		;ld a,0		;; Index * 3 to account for the length of the jp command
		;ld ($+4),a
		;jr $
	
		call DrawSingleSet:JumpDrawRountine	
		;jr DrawDualSet
		;jr DrawQuadSet

		doMusic:
		push de
    		    	;Calls the player, shows some colors to see the consumed CPU.
  		      	call PLY_AKG_Play
		pop de
	pop iy
jr Sync

ScreenIndexCountdown	db 16	;; TODO Should use some code to init this

ScreenDrawTable:	
	dw DrawSingleSet
	db 16
	dw DrawDualSet
	db 16
	dw DrawQuadSet
	db 16
	dw DrawSingleSet
	db 16
	db 0	

DrawDualSet:

ret

DrawQuadSet:

ret

DrawSingleSet:
	;; INPUTS
	;; HL = Starting screen address 
	;; E = Top of the VU
	;; Hard coded widths of columns, but should all be contained in here	

	;; Draw one column
	ld b,26		;; X
	ld c,100	;; Y
	call GetScreenPos;
	push hl
		ld b,84		;; lines tall
		ld c,6		;; bytes wide
		
		call DrawColumn
		call IncrementEqualiser

		;; Then half of the middle column
		ld b,34		;; X
		ld c,100	;; Y
		call GetScreenPos;
		ld b,84		;; lines tall
		ld c,3
		call DrawColumn
		call IncrementEqualiser
	pop hl			;; Restore the scr address of the first row drawn

	ld b,42	;; No. lines tall /2
	_mirrorColumns:
	push de
	push bc
	push hl		;; Preserve the scr address of the first byte of the first line
			
			;; IY must hold the scr address of the end of the line
			;; So HL is needed point to the data at the start of the line
		
			ld a,24		;; full the width of the drawing area in bytes
			;; need to do this manually as won't be able to push/pop HL
			;; iy = hl + a		;; If HL == 84C6 Assert IY = 84C6 + 40d = 84EE
			add   a, l    ; A = A+L
			ld    iyl,a    ; iyl = A+L	
  			adc   a,h    	; A = A+L+H+carry
    			sub   iyl       ; A = iyl+carry
    			ld    iyh, a    ; D = iyl+carry
	
		
			ld b,6			;; Words to copy
			di			;; We automatically get an ei when RST #38 triggers, thus screwing us over as that appears to write a byte to the stack 
			ld (StackBackup),sp
			ld sp,iy		;; Put the stack pointer at far right of the area we want to draw
			_copyLine:
				ld d,(hl)		;; Load de with the pixel byte from hl
				inc hl
				ld e,(hl)
				inc hl		
				push de			;; Push it into the copy
				djnz _copyLine		
			ld sp,(StackBackup)
			ei
	pop hl
	pop bc
	
	Call GetNextLine
	Call GetNextLine
	pop de
	djnz _mirrorColumns	
ret

IncrementEqualiser:
	inc ix
	ld e,(ix)
	ld a,e
	cp 0 
	jr z,resetEqualiser
		ret
	resetEqualiser:
		ld ix,Equaliser
		ld e,(ix)
ret 
      
DrawColumn:
	;; INPUTS
	;; HL = Starting screen address -> Mutates, has coord of the last line
	;; E = Top of the VU
	;; C = Width
	;; B = Total number of lines
	
	sra b		;; Half these values as we are drawring two lines at a time
	sra e
		
	push bc
		;; TODO This need a zero check so in order for the colours to reach the top of the bar
		ld a,b
		sub e
		ld b,a
	
		ld d,&ff
		call DrawColouredLine
	pop bc

	ld b,e		;; B = the top line of the VU

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
	;; HL = Scr Address
	;; B = Number of lines to draw
	;; D = Byte to draw
	;; C = width
	push bc
	push de		;; Preserve the pallet colour for the next row	
	
		push hl		;; Preserve HL while we add the X values
		push bc		;; Preserve the width in C
			ld (hl),d
			push hl
			pop de
			inc de
			ld b,0
			ldir			
		pop bc
		pop hl		;; Return HL to the start of the row
		
			call GetNextLine
			call GetNextLine
	pop de
	pop bc	
	djnz DrawColouredLine
ret

align 2
Equaliser:	;; No need to be even
	db 72,40,40,40,40,40,40,40,40,40
	db 40,40,40,40,40,40,40,40,40,40,0

ScreenStartAddressFlag:	db 48  
ScreenOverflowAddress: 	dw &BFFF
BackBufferAddress: 	dw &8000 
StackBackUp		dw 0

read "./libs/CPC_V2_SimplePalette.asm"
read "./libs/CPC_SimpleScreenSetUp.asm"

;write direct 'music.bin',&4000
org &4000
Music_Start:
	read "./artifacts/axelf_winape.asm"
Music_End:
