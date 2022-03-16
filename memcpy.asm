BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL _memcpy ; Export 'memcpy'
_memcpy:

  PUSH  RCX          ; save and clear out counter
  XOR   RCX, RCX
	CMP	RDI, byte 0	   ; str to change is NULL ?
	JE	_memcpy_end	   ; yes ? go end 
	CMP	RSI, byte 0	   ; str to copy is NULL ?
	JE	_memcpy_end	   ; yes ? go end 

_memcpy_next:

  CMP byte[RSI + RCX], byte 0 ; str to cpy is ended ?
  JE _memcpy_end              ; yes ? go end

  CMP RCX, RDX       ; is number of change done ?
  JE _memcpy_end     ; yes ? end it

  MOV R11B, byte [RSI + RCX]
  MOV [RDI + RCX], R11B  ; is char we look for?
  INC RCX                ; move to next char
  JMP _memcpy_next       ; repeat

_memcpy_end:

  MOV RAX, RDI       ; RDI = the changed pointer (put in rax)
  POP RCX            ; restore rcx
  RET
