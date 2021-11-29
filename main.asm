        ;Tests the AKG player, for the AMSTRAD CPC.
        ;This compiles with RASM. Please check the compatibility page on the website, you can convert these sources to ANY assembler!

        ;Uncomment this to build a SNApshot, handy for testing (RASM feature).
        ;builds
        ;bankset 0

        org &1000
nolist
;write direct 'axelf.bin',&1000
;FlashBorder equ 1

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

	ld ix,VolumeTrack+1		;; This currently needs to be preseved throughout


SyncForScreenSetUp:   ld b,&f5
        in a,(c)
        rra
        jr nc,SyncForScreenSetUp + 2

	call SwitchScreenBuffer
	call ClearScreen

	call Palette_Init
	
	halt
	halt


;; I need to keep to 19968 cycles between calls
PlayMusicAndSync
	call PLY_AKG_Play

Sync:   ld b,&f5
        in a,(c)
        rra
        jr nc,Sync + 2
	
	xor a
	add 1:@screenFlipToggle
	
	jr z,@doLayoutCheck
		xor a
		ld (@screenFlipToggle-1),a
		call SwitchScreenBuffer
	@doLayoutCheck

	ld a,(PLY_AKG_EVENT)		
	cp a,0	
	;jr @doDrawing
	jr z,@doDrawing	

		bit 0,a
		jr z,@checkForDual
			call ClearForNextSet
			ld hl,DrawSingleSet
			ld (DrawRoutine-2),hl
			ld hl,ClearSingleSet
			ld (ClearRoutine-2),hl
			ld hl,IncrementSingleVolume
			ld (IncrementRoutine-2),hl
			jr @doDrawing		
 
		@checkForDual
		bit 1,a
		jr z,@setQuad;; TODO Hacked away
			call ClearForNextSet
			ld hl,DrawDualSet
			ld (DrawRoutine-2),hl
			ld hl,ClearDualSet
			ld (ClearRoutine-2),hl
			ld hl,IncrementDualVolume
			ld (IncrementRoutine-2),hl
			jr @doDrawing	

		@setQuad
			call ClearForNextSet
			ld hl,DrawQuadSet
			ld (DrawRoutine-2),hl
			ld hl,ClearQuadSet
			ld (ClearRoutine-2),hl
			ld hl,IncrementQuadVolume
			ld (IncrementRoutine-2),hl

	@doDrawing:
		call DrawQuadSet:DrawRoutine	
jr PlayMusicAndSync

ClearForNextSet:
	call ClearQuadSet:ClearRoutine
ret
	
;; TODO these all need to be padded out so that they are the same length and some of them are too long still
DrawQuadSet:
	call DrawQuadSetPhaseOne:@quadNextDraw
ret		

DrawQuadSetPhaseOne:
	ld b,10		;; X
	ld c,110	;; Y	
	call GetScreenPos
	call DrawColumns
		
	ld hl,DrawQuadSetPhaseTwo
	ld (@quadNextDraw-2),hl
ret

DrawQuadSetPhaseTwo:
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

	ld hl,DrawQuadSetPhaseThree
	ld (@quadNextDraw-2),hl
ret

DrawQuadSetPhaseThree:
	;; TODO 17498 - this might be too much
	;; Now copy what we just drew into the top half of the screen
	ld b,10			;; X
	ld c,110		;; Y
	call GetScreenPos	;; HL == start point

	push hl
		ld b,46+BlockWidth+1	;; X
		ld c,10		;; Y
		call GetScreenPos	;; <-- this is wasteful as the line number won't change

		push hl
		pop iy		;; IY = destination address 
	pop hl

	ld b, BlockHeight/2
	ld c, 29
	call BlockCopy

	ld hl,DrawQuadSetPhaseOne
	ld (@quadNextDraw-2),hl
	
	ld a,1
	ld (@screenFlipToggle-1),a
ret

ClearQuadSet:
	;; TODO 96436 cycles long, definetly needs chopping down
	;; 38367 - still some to go though
	;; INPUTS
	;; TODO Learn about defining macros!!

	;; BOTTOM LEFT
	ld b,10+BlockWidth+3	;; X
	ld c,110		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth/2+2	
	
	call ClearArea

	;; BOTTOM RIGHT
	ld b,46+BlockWidth+1	;; X
	ld c,110		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth/2+2	
	
	call ClearArea	
	
	;; TOP LEFT
	ld b,10+BlockWidth+3	;; X
	ld c,10			;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth/2+2	
	
	call ClearArea	

	;; TOP RIGHT
	ld b,46+BlockWidth+1	;; X
	ld c,10			;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth/2+2	
	
	call ClearArea	

	;; SWITCH AND REPEAT
	call SwitchScreenBuffer

	;; BOTTOM LEFT
	ld b,10+BlockWidth+3	;; X
	ld c,110		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth/2+2	
	
	call ClearArea

	;; BOTTOM RIGHT
	ld b,46+BlockWidth+1	;; X
	ld c,110		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth/2+2	
	
	call ClearArea	
	
	;; TOP LEFT
	ld b,10+BlockWidth+3	;; X
	ld c,10		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth/2+2	
	
	call ClearArea	

	;; TOP RIGHT
	ld b,46+BlockWidth+1	;; X
	ld c,10		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth/2+2	
	
	call ClearArea	

ret	

DrawSingleSet:

	ld b,28		;; X
	ld c,110	;; Y
	call GetScreenPos
	call DrawColumns

	ld a,1
	ld (@screenFlipToggle-1),a
	
ret

ClearSingleSet:
	;; INPUTS
	ld b,28+BlockWidth+3	;; Xpos plus width, plus 2 becasue the sp moves before writing
	ld c,110		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth/2+2		
	
	call ClearArea

	call SwitchScreenBuffer

	ld b,28+BlockWidth+3	;; X
	ld c,110		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth/2+2		
	
	call ClearArea

ret

DrawDualSet:
	call DrawDualSetPhaseOne:@dualNextDraw
ret

DrawDualSetPhaseOne:
	ld b,10		;; X
	ld c,110	;; Y	
	call GetScreenPos
	call DrawColumns
	
	ld hl,DrawDualSetPhaseTwo
	ld (@dualNextDraw-2),hl	
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

	ld hl,DrawDualSetPhaseOne
	ld (@dualNextDraw-2),hl

	ld a,1
	ld (@screenFlipToggle-1),a
ret

ClearDualSet:
	;; TODO 24115 - also far too slow
	;; 18089 - still needs some more
	;; INPUTS
	ld b,46+BlockWidth+1	;; X
	ld c,110		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth+9	
	
	call ClearArea	

	call SwitchScreenBuffer

	ld b,46+BlockWidth+1	;; X
	ld c,110		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	ld c,BlockWidth+9	
	
	call ClearArea	
ret	

ClearArea
	;; INPUTS
	;; HL	=  scr start of the area to clear
	;; C	= bytes to clear 	
	push bc			;; Preserve the width in C
		push hl		;; Preserve HL while we add the X values
		
			;ld a,10
			;add l ;; BlockWidth/2
			;ld l,a
			ld d,%1111000
			ld e,%1111000
			ld b,c
			di
			ld (StackBackUp),sp
			ld sp,hl
			@clearLine
				push de
			djnz @clearLine
			ld sp,(StackBackUp)
			ei

			;ld (hl),&ff
			;push hl
			;pop de
			;inc de
			;ld b,0
			;ldir	;; TODO this could also use the stack		
	
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
			;ld d,%11110000
			;ld e,%11110000		
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

IncrementVolumeTrack:
	Call IncrementDualVolume:IncrementRoutine
	ld a,(ix)
	cp 0 
	jr z,resetEqualiser
		ret
	resetEqualiser:
		ld ix,VolumeTrack

ifdef FlashBorder
        ld bc,#7f10
        out (c),c
        ld a,#4b
        out (c),a
endif
ret

IncrementSingleVolume:
	inc ix
ret

IncrementDualVolume:
	inc ix
	inc ix
ret

IncrementQuadVolume:
	inc ix
	inc ix
	inc ix
ret

DrawColumns:
	;; INPUTS
	;; HL = XY of the bounding box
	;; Hard coded widths of columns, but should all be contained in here	

	push hl
		ld c,6			;; bytes wide
		ld e,(ix)
		call DrawColumn
		call IncrementVolumeTrack
	pop hl			;; Restore the scr address of the first row drawn
	push hl
	
		;; Then draw half of the middle column
		inc hl ;; Account for the gap between them
		ld a,l
		add 7
		ld l,a
		ld c,3
		ld e,(ix)
		call DrawColumn
		call IncrementVolumeTrack
	pop hl			;; Restore the scr address of the first row drawn

	ld b,BlockHeight/2	;; No. lines tall /2

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
	;; E = Volume setting
	
_drawBlackLines:
	ld a,BlockHeight/2
	sub e		;; A now holds the of lines to clear
	ld b,e		;; E = lines lines left to draw after black
	jr z,_drawRedLines
	
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
	push bc		;; Preserve the width in C	
		push hl		;; Preserve HL while we add the X values		
			ld (hl),&00:PixelToDraw
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

ScreenStartAddressFlag:	db 48  
ScreenOverflowAddress: 	dw &BFFF
BackBufferAddress: 	dw &8000 
StackBackUp		dw 0
BlockWidth equ 20
BlockHeight equ 62

read "./libs/CPC_V2_SimplePalette.asm"
read "./libs/CPC_SimpleScreenSetUp.asm"

;; This needs to be &0480 bytes long
VolumeTrack:
incbin "./resources/volumetrack.bin"
dw 0

;write direct 'music.bin',&4000
org &4000
Music_Start:
	read "./artifacts/axelf_winape.asm"
Music_End:
