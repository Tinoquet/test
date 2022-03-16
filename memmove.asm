BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL _memmove ; Export 'memmove'
_memmove:

  PUSH  RCX             ; save and clear out counter
  XOR   RCX, RCX
	CMP	  RDI, byte 0     ; first str to compare is NULL ?
	JE	  _memmove_end	  ; yes ? go end 
	CMP	  RSI, byte 0	    ; sedond str to copy is NULL ?
	JE	  _memmove_end	  ; yes ? go end
	DEC	  RDX			        ; set RDX to be used to start at end of str

_memmove_loop:

	CMP	RDX,	0             ; is RDX < to zero ?
	JL	_memmove_end        ; yes ? go to end

  MOV	R11B,	[RSI + RDX]   ; put source memory into tmp
  MOV	[RDI + RDX],	R11B  ; put tmp int dest memory
	DEC	RDX
	JMP	_memmove_loop       ; repeat

_memmove_end:

  MOV	RAX, RDI	; RDI = the changed pointer (put in rax)
	POP	RCX		    ; restore RCX
	RET
