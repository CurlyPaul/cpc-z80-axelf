        ;Tests the AKG player, for the AMSTRAD CPC.
        ;This compiles with RASM. Please check the compatibility page on the website, you can convert these sources to ANY assembler!

        ;Uncomment this to build a SNApshot, handy for testing (RASM feature).
        ;buildsna
        ;bankset 0

        org &8000
source_address equ &C000 ;; Using the screen as it's easier
source_length equ &0238

run Start
Start:

ClearScreen:
	ld hl,&c000
	ld d,h
	ld e,l
	inc de
	ld bc,&3FEE		;; Number of bytes to clear
	ld (hl),0
	ldir	

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

	ld ix,source_address-1

Sync:   ld b,&f5
        in a,(c)
        rra
        jr nc,Sync + 2

        ei

	

        ;nop
        halt
        halt
        ;ld sp,&38

        ld b,80
        djnz $  	;; Effectively sets the speed by wasting 90*4 cycles

	;ld a,(PLY_AKG_EVENT)		
	;cp a,1
	;jr nz, CheckEnd
	;;	ld a,0:EndOnNextEvent	
	;	cp a,1
	;	jr z,SaveOnNextEvent
	;CheckEnd
	;cp a,&ff
	;jr nz,DoMusic
	;	ld a,1
	;	ld (EndOnNextEvent-1),a


DoMusic
	ld a,8 	;; Channel A volume
	call AYRegRead
	add a	;; A = A*2
	add a	;; A = A*4		
	rra
	inc a

	ld (ix),a
	inc ix

	ld a,10 	;; Channel C volume
	call AYRegRead
	add a
	add a
	rra	
	inc a

	ld (ix),a
	inc ix

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

SaveOnNextEvent:
	nop ;; break here to copy values from memory
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

.cas_out_open equ &bc8c
.cas_out_close equ &bc8f
.cas_out_char equ &bc95

WriteBufferToDisk:

;; Didn't get this fully working, AKG uses exx and the firmware needs the standard interrupts
;; Also, when it does work, it corrupts the screen

Call &41F5
di
ld hl,&39c3
ld (&0038),hl
ei
nop
halt 
halt

ld hl,&C000				;; start address of data to write (example)
ld bc,&0238				;; length of data to write (example)
push hl
push bc

;; open output file
ld b,end_filename-filename
ld hl,filename
ld de,two_k_buffer
call cas_out_open

;; at this point the file will be opened for output.
;; A header is *not* created or written to the output
;; file

pop bc
pop hl

;; HL = start address of data to write
;; BC = length of data to write

.next_byte
ld a,(hl)		;; read byte from memory
inc hl		;; increment point

;; write byte to output file
push bc
push hl
call cas_out_char
pop hl
pop bc

;; decrement count (BC = number of bytes remaining to write to
;; output file)
dec bc

;; BC = 0 -> finished writing
;; BC <> 0 -> not finished. write more bytes
ld a,b
or c
jr nz,next_byte

;; close the output file
call cas_out_close
ret

OGIntHandler: dw 0

;; FILE.BIN but with bit 7 set on extension bytes
filename:
defb "RAWVOLA."
defb 'B' ;;+&80
defb 'I' ;;+&80
defb 'N'
end_filename:

Two_K_buffer: defs 2048

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
