        ;Tests the AKG player, for the AMSTRAD CPC.
        ;This compiles with RASM. Please check the compatibility page on the website, you can convert these sources to ANY assembler!

        ;Uncomment this to build a SNApshot, handy for testing (RASM feature).
        ;builds
        ;bankset 0

        org &1000
;nolist
Release equ 1
;FlashBorder equ 1

ifdef Release
	write direct 'axelf.bin',&1000
endif 

;run Start
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

	ld ix,VolumeTrack+1		;; IX currently needs to be preseved throughout


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
	call PLY_AKG_Play 	;; 1041 cycles!!

Sync:   ld b,&f5
        in a,(c)
        rra
        jr nc,Sync + 2
	
	xor a
	add 1:@screenFlipToggle
	jr z,@doLayoutCheck
		xor a
		ld (@screenFlipToggle-1),a
		call SwitchScreenBuffer				;; Switch the back buffer to the front here
		
		xor a
		add 0:@clearPreviousToggle
		jr z,@doLayoutCheck
			xor a
			ld (@clearPreviousToggle-1),a
			call ClearSingleSetGfx:ClearPreviousGfxRoutine	
	@doLayoutCheck
	ld a,(PLY_AKG_EVENT)		
	cp a,0	
	;jr @doDrawing
	jr z,@doDrawing	
		call ClearSingleSetGfx:ClearCurrentGfxRoutine

		ld hl,(ClearCurrentGfxRoutine-2)
		ld (ClearPreviousGfxRoutine-2),hl

		ld a,1
		ld (@clearPreviousToggle-1),a
		
		ld a,(PLY_AKG_EVENT)		
		bit 0,a
		;jr @checkForDual
		jr z,@checkForDual
			ld hl,DrawSingleSetGfx
			ld (DrawRoutine-2),hl

			ld hl,ClearSingleSetGfx
			ld (ClearCurrentGfxRoutine-2),hl

			ld hl,IncrementSingleVolume
			ld (IncrementRoutine-2),hl

			jr @doDrawing		
 
		@checkForDual
		bit 1,a
		;jr @setQuad
		jr z,@setQuad
			ld hl,DrawDualSetGfx
			ld (DrawRoutine-2),hl
			
			ld hl,ClearDualSetGfx
			ld (ClearCurrentGfxRoutine-2),hl

			ld hl,IncrementDualVolume
			ld (IncrementRoutine-2),hl

			jr @doDrawing	

		@setQuad		
			ld hl,DrawQuadSetGfx
			ld (DrawRoutine-2),hl

			ld hl,ClearQuadSetGfx
			ld (ClearCurrentGfxRoutine-2),hl

			ld hl,IncrementQuadVolume
			ld (IncrementRoutine-2),hl

	@doDrawing:
		call DrawSingleSetGfx:DrawRoutine	
jp PlayMusicAndSync

;; TODO Do these functions need to be padded to the same length so that ply in called regularly
;; TODO Channel A isn't very interesting to look at - generate fresh music track ;P

;; Drawing more than one VU requires more than one vbc to be able to draw all of them
;; These exist so that I can incremently call different phases
DrawQuadSetGfx:
	call DrawQuadSetGfxPhaseOne:@quadNextDraw
ret		

DrawDualSetGfx:
	call DrawDualSetGfxPhaseOne:@dualNextDraw
ret


DrawQuadSetGfxPhaseOne:
	ld b,12		;; X
	ld c,128	;; Y	
	call GetScreenPos
	call DrawColumns
		
	ld hl,DrawQuadSetGfxPhaseTwo
	ld (@quadNextDraw-2),hl
ret

DrawQuadSetGfxPhaseTwo:
	ld b,12			;; X
	ld c,128		;; Y
	call GetScreenPos	
	push hl
	pop iy	
	
	ld a,l
	add 55
	ld iyl,a	

	ld b, BlockHeight/2
	call BlockCopy

	ld hl,DrawQuadSetGfxPhaseThree
	ld (@quadNextDraw-2),hl
ret

DrawQuadSetGfxPhaseThree:
	;; Now copy what we just drew into the top half of the screen
	ld b,46+BlockWidth+1	;; X
	ld c,12		;; Y
	call GetScreenPos	
	push hl
	pop iy	;; destination address
	
	ld b,12		;; X
	ld c,128	;; Y	
	call GetScreenPos	;; HL source address
				;; <-- this is wasteful as the line number won't change	l

	ld b, BlockHeight/2
	ld c, 28
	call BlockCopyRow

	ld hl,DrawQuadSetGfxPhaseOne
	ld (@quadNextDraw-2),hl
	
	ld a,1
	ld (@screenFlipToggle-1),a
ret

ClearQuadSetGfx:
	;; INPUTS

	;; BOTTOM ROW
	ld b,46+BlockWidth+1	;; X
	ld c,128		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	call ClearFullRow	

	;; TOP ROW
	ld b,46+BlockWidth+1	;; X
	ld c,12			;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	call ClearFullRow		
ret	

DrawSingleSetGfx:
	;; 10178
	ld b,28				;; X
	ld c,128			;; Y
	call GetScreenPos
	call DrawColumns

	ld a,1
	ld (@screenFlipToggle-1),a
ret

ClearSingleSetGfx:
	;; INPUTS
	ld b,30+BlockWidth+2	;; Xpos plus width, plus 2 becasue the sp moves before writing
	ld c,128		;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2
	@clearNextLineSingleSet
	ld de,&ffff
	di
		ld (StackBackUp),sp
		ld sp,hl
		repeat 12
		push de
		rend	
		ld sp,(StackBackUp)
	ei		
	call GetNextAltLine
	djnz @clearNextLineSingleSet
ret

DrawDualSetGfxPhaseOne:
	ld b,12		;; X
	ld c,128	;; Y	
	call GetScreenPos
	call DrawColumns
	
	ld hl,DrawDualSetGfxPhaseTwo
	ld (@dualNextDraw-2),hl	
ret	

DrawDualSetGfxPhaseTwo
	ld b,46+BlockWidth+1	;; X
	ld c,128		;; Y
	call GetScreenPos	
	push hl
	pop iy	;; destination address
	
	ld b,12			;; X
	ld c,128		;; Y	
	call GetScreenPos 	;; Hl now holds the source address
	
	ld b, BlockHeight/2
	ld c, 20/2 + 2	;; BlockWidth / (bytes per word) + Adjust for way SP moves before writing
	call BlockCopy

	ld hl,DrawDualSetGfxPhaseOne
	ld (@dualNextDraw-2),hl

	ld a,1
	ld (@screenFlipToggle-1),a
ret

ClearDualSetGfx:
	;; INPUTS
	ld b,46+BlockWidth+1	;; X
	ld c,128				;; Y
	call GetScreenPos	;; HL = starting screen position
	
	ld b,BlockHeight/2	
	call ClearFullRow	
ret	

ClearFullRow:
	;; INPUTS
	;; HL = Left most scr address to clear
	;; B  = Lines to clear

	ld de,&ffff
	di
		ld (StackBackUp),sp
		ld sp,hl
		repeat 28
		push de
		rend	
		ld sp,(StackBackUp)
	ei		
	call GetNextAltLine

	djnz ClearFullRow
ret

BlockCopy
	;; INPUTS
	;; HL Source screen address
	;; IY Dest screen address 
	;; B Lines / 2
	push hl
		di			 
		ld (StackBackup),sp
		ld sp,iy:			;; Put the stack pointer at far right of the area we want to draw
		;@copyLine
		repeat 12
			ld d,(hl)		;; Load de with the pixel byte from hl
			inc hl
			ld e,(hl)
			inc hl	
			push de			;; Push it into the copy
		rend		
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

	djnz BlockCopy
ret

BlockCopyRow
	;; INPUTS
	;; HL Source screen address
	;; IY Dest screen address 
	;; B Lines / 2
	push hl
		di			 
		ld (StackBackup),sp
		ld sp,iy:			;; Put the stack pointer at far right of the area we want to draw
		repeat 27
			ld d,(hl)		;; Load de with the pixel byte from hl
			inc hl
			ld e,(hl)
			inc hl	
			push de			;; Push it into the copy
		rend		
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

	dec b
	jp nz,BlockCopyRow
ret

IncrementVolumeTrack:
	Call IncrementDualVolume:IncrementRoutine
	ld a,(ix)
	cp 0 
	jr z,resetVolumeTrack
		ret
	resetVolumeTrack:
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
	;; HL = XY
	
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

	@mirrorColumns:	
	push hl		;; Preserve the scr address of the first byte of the first line
			
			;; Need to manouvre IY so that it contains the address of the last pixel on the right
			;; HL needs to be reset to hold the staring position of the first pixel
			ld a,23		;; full the width of the drawing area in bytes
			;; need to do this manually as won't be able to push/pop HL
			;; iy = hl + a		;; If HL == 84C6 Assert IY = 84C6 + 40d = 84EE
			add   a, l    ; A = A+L
			ld    iyl,a    ; iyl = A+L	
  			adc   a,h    	; A = A+L+H+carry
    			sub   iyl       ; A = iyl+carry
    			ld    iyh, a    ; D = iyl+carry
			
			di				;; We automatically get an ei when RST #38 triggers, thus screwing us over as that appears to write a byte to the stack 
				ld (StackBackup),sp
				ld sp,iy		;; Put the stack pointer at far right of the area we want to draw
				repeat 6
				ld d,(hl)		;; Load de with the pixel byte from hl
				inc hl
				ld e,(hl)
				inc hl		
				push de			;; Push it into the copy
				rend		
				ld sp,(StackBackup)
			ei
	pop hl
	
	Call GetNextAltLine

	djnz @mirrorColumns	
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

ifdef Release
	write direct 'music.bin',&4000
endif

org &4000
Music_Start:
	read "./artifacts/axelf_winape.asm"
Music_End:



