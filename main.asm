        ;Tests the AKG player, for the AMSTRAD CPC.
        ;This compiles with RASM. Please check the compatibility page on the website, you can convert these sources to ANY assembler!

        ;Uncomment this to build a SNApshot, handy for testing (RASM feature).
        ;builds
        ;bankset 0

        org &1000
nolist
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

SyncForScreenSetUp:   ld b,&f5
        in a,(c)
        rra
        jr nc,SyncForScreenSetUp + 2

	call SwitchScreenBuffer
	call ClearScreen

	call Palette_Init
	ld ix,ScreenDrawTable

SyncAndFlipBuffer:   ld b,&f5
        in a,(c)
        rra
        jr nc,SyncAndFlipBuffer + 2

	call SwitchScreenBuffer	
	jr @checkscreentable

Sync:   ld b,&f5
        in a,(c)
        rra
        jr nc,Sync + 2
	@checkscreentable
	;; TODO Add events to the track at the points I want to change, and use the fake switch statement to change which screen gets drawn
	ld a,(PLY_AKG_TICKDECREASINGCOUNTER)	;; PLY_AKG_TICKDECREASINGCOUNTER but defined in a way winape doesn't get	
	cp a,1
	jr nz,@doDrawing
		;; decrement our slow ticker
		ld a,(ScreenIndexCountdown)
		dec a
		jr nz,@saveIndexAndDoDrawing
			inc ix
			inc ix
			inc ix
			ld a,(ix)
			cp a,0
			jr nz,@resetCountdownAndChangeScreen
				ld ix,ScreenDrawTable	;; Reset the screen script to the start
				ld a,(ix)
			@resetCountdownAndChangeScreen
			ld h,(ix+1)
			ld l,a
			ld (JumpDrawRountine-2),hl

			ld a,(ix+2)
			
	@saveIndexAndDoDrawing
		ld (ScreenIndexCountdown),a
	@doDrawing:
		call PLY_AKG_Play
		call DrawDualSet:JumpDrawRountine	

jr Sync

ScreenIndexCountdown	db 16	;; TODO Should use some code to init this

ScreenDrawTable:	
	dw ClearDualSet
	db 15
	dw ClearDualSet	;; TODO Having this here leaves me with a blank frame
	db 1
	dw DrawDualSet
	db 15
	dw ClearDualSet
	db 1
	dw DrawSingleSet
	db 15
	dw ClearSingleSet
	db 1
	dw DrawQuadSet
	db 15
	dw ClearQuadSet
	db 1
	dw 0	

DrawQuadSet:
	call DrawDualSet

	ld b,10			;; X
	ld c,110		;; Y
	call GetScreenPos	;; HL == start point

	push hl
		;ld de,10	;; screen width - 10 pixel border
		;add hl,de
		;inc hl

		ld b,46+BlockWidth+1	;; X
		ld c,10		;; Y
		call GetScreenPos	;; <-- this is wasteful as the line number won't change

		push hl
		pop iy		;; IY = destination address 
	pop hl

	ld b, BlockHeight/2
	ld c, 29
	call BlockCopy
ret

ClearQuadSet:
	;; INPUTS
	call ClearDualSet

	ld b,10			;; X
	ld c,10			;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth+BlockWidth+16	
	
	call ClearArea	
ret	

DrawSingleSet:
	ld b,28		;; X
	ld c,110	;; Y
	call GetScreenPos
	call DrawColumns
ret

ClearSingleSet:
	;; INPUTS
	ld b,28			;; X
	ld c,110		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth+2	;; Don't understand why I need a +2 here	
	
	call ClearArea
ret

DrawDualSet:

	call DrawDualSetPhaseOne:@functionPointer

	ld hl,(@functionPointer-2)
	ld de,DrawDualSetPhaseOne
	sbc hl,de
	
	jr z,@setPhaseTwo
		ld hl,DrawDualSetPhaseOne
		ld (@functionPointer-2),hl
		jp SyncAndFlipBuffer
	@setPhaseTwo
	ld hl,DrawDualSetPhaseTwo
	ld (@functionPointer-2),hl
	jp Sync

DrawDualFunctionPointer: dw 0

DrawDualSetPhaseOne:
	ld b,10		;; X
	ld c,110	;; Y	
	call GetScreenPos
	
	push hl	;; Preseve the address of the first block
		call DrawColumns
	
		ld b,46+BlockWidth+1	;; X
		ld c,110		;; Y
		call GetScreenPos	;; <-- this is wasteful as the line number won't change
		push hl
		pop iy
	pop hl	;; Hl now holds the source address		
ret	

DrawDualSetPhaseTwo
	ld b,10		;; X
	ld c,110	;; Y	
	call GetScreenPos
	
	push hl
		ld b,46+BlockWidth+1	;; X
		ld c,110		;; Y
		call GetScreenPos	;; <-- this is wasteful as the line number won't change
		push hl
		pop iy	;; destination address
	pop hl	;; Hl now holds the source address

	ld b, BlockHeight/2
	ld c, 20/2 + 2	;; BlockWidth / (bytes per word) + Adjust for way SP moves before writing
	call BlockCopy
ret

ClearDualSet:
	;; INPUTS
	ld b,10			;; X
	ld c,110		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth+BlockWidth+16	;; Don't understand why I need a +2 here
	
	call ClearArea	
ret	

ClearArea
	push bc			;; Preserve the width in C
		push hl		;; Preserve HL while we add the X values		
			ld (hl),&ff
			push hl
			pop de
			inc de
			ld b,0
			ldir	;; TODO this could also use the stack		
	
		pop hl		;; Return HL to the start of the row	
		call GetNextAltLine

	pop bc	
	djnz ClearArea
ret

BlockCopy
	;; INPUTS
	;; HL source screen address 
	;; B Lines / 2
	;; C Words to copy
	;; IY Destination X+Width+1,Y

	;; Just like mirror colomns, put the SP at the right of the line
	@copyNextLine
	push bc
	push hl
		ld b,c
		di			 
		ld (StackBackup),sp
		ld sp,iy		;; Put the stack pointer at far right of the area we want to draw
		@copyLine:
			ld d,(hl)		;; Load de with the pixel byte from hl
			inc hl
			ld e,(hl)
			inc hl		
			push de			;; Push it into the copy
		djnz @copyLine		
		ld sp,(StackBackup)
		ei
	pop hl	;; restore the start address'

	call GetNextAltLine

	push hl
		push iy			;; IY is the stack pointer address
		pop hl			;; pop it onto HL
		call GetNextAltLine	;; so that I can advance to the next line
		push hl
		pop iy
	pop hl 
	pop bc

	djnz @copyNextLine
ret

AYRegRead:
	;; INPUT
	;; A = AY Reg to read
	;; OUTPUT
	;; A = Reg Value
	;; DESTROYS BC
		push bc
			ld b,&f4
			ld c,a
			out (c),c	;#f4 Regnum

			ld bc,&F6C0	;Select REG
			out (c),c	

			ld bc,&f600	;Inactive
			out (c),c

			;; PPI port A set to input, PPI port B set to input,
			;; PPI port C (lower) set to output, PPI port C (upper) set to output
			ld bc,&f700+%10010010
			out (c),c

			ld bc,&F640	;Read VALUE
			out (c),c	
		pop bc

		ld b,&F4		;#f4 value
		in a,(c)

		;; PPI port A set to output, PPI port B set to input,
		;; PPI port C (lower) set to output, PPI port C (upper) set to output
		ld bc,&f700+%10000010
		out (c),c

		ld bc,&f600		;inactive
		out (c),c
ret

DrawColumns:
	;; INPUTS
	;; HL = XY of the bounding box
	;; Hard coded widths of columns, but should all be contained in here	

	push hl
		ld c,6			;; bytes wide
		call DrawColumn

	pop hl			;; Restore the scr address of the first row drawn
	push hl
	
		;; Then draw half of the middle column
		inc hl ;; Account for the gap between them
		ld a,l
		add 7
		ld l,a
		ld c,3
		call DrawColumn

	pop hl			;; Restore the scr address of the first row drawn

	ld b,BlockHeight/2	;; No. lines tall /2

	;; TODO it seems to be missing the bottom row
	_mirrorColumns:
	push bc
	push hl		;; Preserve the scr address of the first byte of the first line
			
			;; IY must hold the scr address of the end of the line
			;; So HL is needed point to the data at the start of the line
			ld a,23		;; full the width of the drawing area in bytes
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
	
	Call GetNextAltLine

	djnz _mirrorColumns	
ret
      
DrawColumn:
	;; INPUTS
	;; HL = Starting screen address -> Mutates, has coord of the last line
	;; C = Width
	
	push bc
		ld a,8 	;; Channel A volume
		call AYRegRead
		add a	;; Value is in the range 0-15 and our vu is 75 lines tall, so multiply by 3
		add a
		ld e,a
		sra e	;; And then divide by two as I'm only drawing alt. lines
		inc e	;; Now add a line to save a zero check
	pop bc


@drawColours

_drawBlackLines:
	ld a,BlockHeight/2
	sub e		;; A now holds the of lines to clear
	ld b,e		;; E = lines lines left to draw after black

	push bc	;; Need to preserve the width held in C
		ld b,a
		ld a,%00001111
		ld (PixelToDraw-1),a
		call DrawColouredLine
			
	pop bc
_drawRedLines:
	ld a,b
	sub 25		;; Red threshold/2
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
			ld a,%11000000
			ld (PixelToDraw-1),a
			call DrawColouredLine
		pop bc
	
_drawOrangeLines:
		ld a,b
		sub 18		;; Orange threshold/2
				;; A now holds the number of lines to draw in orange
	jp m,_drawYellowLines
	jr z,_drawYellowLines 
		ld e,a		;; stash the no. orange lines to draw in e for a while
		ld a,b
		sub e
		ld b,a
		push bc
			ld b,e	
			ld a,%00001100
			ld (PixelToDraw-1),a
			call DrawColouredLine
		pop bc

_drawYellowLines:
		ld a,b
		sub 15		;; Yellow threshold/2
	jp m,_drawGreenLines
	jr z,_drawGreenLines 
		ld e,a		
		ld a,b
		sub e
		ld b,a
		push bc
			ld b,e	
			ld a,%11001100
			ld (PixelToDraw-1),a
			call DrawColouredLine
		pop bc

	_drawGreenLines:
		ld a,%00000000
		ld (PixelToDraw-1),a
		call drawColouredLine

ret

DrawColouredLine:
	;; INPUTS
	;; HL = Scr Address
	;; B = Number of lines to draw
	;; C = width
	;; DESTROYS BC DE
	;; MUTATES HL to the adddress of the first byte of the last line
	bit 7,b
	ret nz		;; TODO Despite never being true, this causes a reset with dual columns
	push bc		;; Preserve the width in C	
		push hl		;; Preserve HL while we add the X values		
			ld (hl),&00:PixelToDraw	;; TODO Could self mod this and save another push pop
			push hl
			pop de
			inc de
			ld b,0
			ldir			
		pop hl		;; Return HL to the start of the row
		call GetNextAltLine
	pop bc	
	djnz DrawColouredLine
	ret
ret

ScreenStartAddressFlag:	db 48  
ScreenOverflowAddress: 	dw &BFFF
BackBufferAddress: 	dw &8000 
StackBackUp		dw 0
BlockWidth equ 20
BlockHeight equ 76

read "./libs/CPC_V2_SimplePalette.asm"
read "./libs/CPC_SimpleScreenSetUp.asm"

;write direct 'music.bin',&4000
org &4000
Music_Start:
	read "./artifacts/axelf_winape.asm"
Music_End:
