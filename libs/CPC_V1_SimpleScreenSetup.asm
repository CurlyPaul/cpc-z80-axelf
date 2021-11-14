CRTC_4000 equ 16
CRTC_8000 equ 32
CRTC_C000 equ 48

Screen_Init:
	; Sets the screen to 16 colour/160 wide mode
	ld a,0
	call &BC0E	; scr_set_mode 0 - 16 colors
ret

ClearScreen:
	ld hl,(BackBufferAddress)
	ld d,h
	ld e,l
	inc de
	ld bc,&3FEE		;; Number of bytes to clear
	ld (hl),&FF
	ldir	
ret

GetScreenPos:
	;; Inputs: BC - X Y
	;; Returns HL : screen memory locations
	;; Destroys BC

	;; Calculate the ypos first
	ld hl,scr_addr_table	; load the address of the label into h1

	;; Now read two bytes from the address held in hl. We have to do this one at a time
	ld a,c
	add   a, l    ; A = A+L
	ld    l, a    ; L = A+L	
   	adc   a, h    ; A = A+L+H+carry
    	sub   l       ; A = H+carry
    	ld    h, a    ; H = H+carry

	ld a,c
	add   a, l    ; A = A+L
   	ld    l, a    ; L = A+L	
    	adc   a, h    ; A = A+L+H+carry
    	sub   l       ; A = H+carry
    	ld    h, a    ; H = H+carry

	ld a,(hl)		; stash one byte from the address in hl into a
	inc l			; increment the address we are pointing at
	ld h,(hl)		; load the next byte into the address at h into h
	ld l,a			; now put the first byte we read back into l

	;; Now calculate the xpos, this is much easier as these are linear on the screen screen				
	ld a,b				; need to stash b as the next op insists on reading 16bit - we can't to ld c,(label)
	ld bc,(BackBufferAddress)	; bc now contains either &4000 or &C000, depending which cycle we are in
	ld c,a				; bc will now contain &40{x}
	add hl,bc			; hl = hl + bc, add the x and y values together
ret

GetNextLine:
	;; Inputs: HL Current screen memory location
	;; Returns: HL updated to the start of the next line
	ld a,h				; load the high byte of hl into a
	add &08				; it's just a fact that each line is + &0800 from the last one
	ld h,a				; put the value back in h

_screenBankMod_Minus1:
	bit 7,h		;Change this to bit 6,h if your screen is at &8000!
	jr nz,_getNextLineDone
	ld de,&C050 	;; x64  bytes 
	add hl,de
_getNextLineDone:
ret



SwitchScreenBuffer:
	; Flips all the screen buffer variables and moves the back buffer onto the screen
	ld a,(ScreenStartAddressFlag)
	sub CRTC_8000
	jr nz, _setScreenBase8000
_setScreenBaseC000:
	ld de,CRTC_C000 
	ld (ScreenStartAddressFlag),de
	ld de,&8000
	ld (BackBufferAddress),de
	;; Remember this is the test for drawing to 8000, not C000
	ld hl,&2874		;; Byte code for: Bit 6,JR Z
	ld (_screenBankMod_Minus1+1),hl
	jr _doSwitchScreen
_setScreenBase8000:
	ld de,CRTC_8000
	ld (ScreenStartAddressFlag),de
	ld de,&C000 
	ld (BackBufferAddress),de 
	ld hl,&207C		;; Byte code for: Bit 7,JR NZ
	ld (_screenBankMod_Minus1+1),hl
_doSwitchScreen:
	ld bc,&BC0C 	; CRTC Register to change the start address of the screen
	out (c),c
	inc b
	ld a,(ScreenStartAddressFlag)
	out (c),a
ret

; This is the screen address table for a standard screen
; Each word in the table is the memory address offest for the start of each screen line
; eg line 1 is at 0000 (scr_start_adr +C000 normally)
;    line 2 is at 0800
;    line 3 is at 1000
;    line 4 is at 1800
;    line 5 is at 2000 etc
align2
scr_addr_table:
	defw &0000,&0800,&1000,&1800,&2000,&2800,&3000,&3800
	defw &0050,&0850,&1050,&1850,&2050,&2850,&3050,&3850
	defw &00A0,&08A0,&10A0,&18A0,&20A0,&28A0,&30A0,&38A0
	defw &00F0,&08F0,&10F0,&18F0,&20F0,&28F0,&30F0,&38F0
	defw &0140,&0940,&1140,&1940,&2140,&2940,&3140,&3940
	defw &0190,&0990,&1190,&1990,&2190,&2990,&3190,&3990
	defw &01E0,&09E0,&11E0,&19E0,&21E0,&29E0,&31E0,&39E0
	defw &0230,&0A30,&1230,&1A30,&2230,&2A30,&3230,&3A30
	defw &0280,&0A80,&1280,&1A80,&2280,&2A80,&3280,&3A80
	defw &02D0,&0AD0,&12D0,&1AD0,&22D0,&2AD0,&32D0,&3AD0
	defw &0320,&0B20,&1320,&1B20,&2320,&2B20,&3320,&3B20
	defw &0370,&0B70,&1370,&1B70,&2370,&2B70,&3370,&3B70
	defw &03C0,&0BC0,&13C0,&1BC0,&23C0,&2BC0,&33C0,&3BC0
	defw &0410,&0C10,&1410,&1C10,&2410,&2C10,&3410,&3C10
	defw &0460,&0C60,&1460,&1C60,&2460,&2C60,&3460,&3C60
	defw &04B0,&0CB0,&14B0,&1CB0,&24B0,&2CB0,&34B0,&3CB0
	defw &0500,&0D00,&1500,&1D00,&2500,&2D00,&3500,&3D00
	defw &0550,&0D50,&1550,&1D50,&2550,&2D50,&3550,&3D50
	defw &05A0,&0DA0,&15A0,&1DA0,&25A0,&2DA0,&35A0,&3DA0
	defw &05F0,&0DF0,&15F0,&1DF0,&25F0,&2DF0,&35F0,&3DF0
	defw &0640,&0E40,&1640,&1E40,&2640,&2E40,&3640,&3E40
	defw &0690,&0E90,&1690,&1E90,&2690,&2E90,&3690,&3E90
	defw &06E0,&0EE0,&16E0,&1EE0,&26E0,&2EE0,&36E0,&3EE0
	defw &0730,&0F30,&1730,&1F30,&2730,&2F30,&3730,&3F30
	defw &0780,&0F80,&1780,&1F80,&2780,&2F80,&3780,&3F80
