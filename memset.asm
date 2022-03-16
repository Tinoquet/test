BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL _memset ; Export 'memset'
_memset:

  PUSH  RCX          ; save and clear out counter
  XOR   RCX, RCX
	CMP	RDI, byte 0	   ; str is NULL ?
	JE	_memset_end	   ; yes ? go end 
  CMP RSI, 0         ; int is neg
  JG _memset_end     ; yes ? end 

_memset_next:

  CMP RCX, RDX       ; is number of change done ?
  JE _memset_end     ; yes ? end it

  MOV byte [RDI + RCX], SIL  ; assign char to mem
  INC RCX            ; move to next char
  JMP _memset_next   ; repeat

_memset_end:

  MOV RAX, RDI       ; RDI = the changed pointer (put in rax)
  POP RCX            ; restore rcx
  RET
