BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL _strncmp ; Export 'strncmp'
_strncmp:

  PUSH  RCX          ; save and clear out counter
  XOR   RCX, RCX
  CMP RDX, 0         ; is number of char to check zero ?
  JZ  _strncmp_zero  ; yes ? go end
	CMP	RDI, byte 0    ; first str to compare is NULL ?
	JE	_strncmp_end	 ; yes ? go end 
	CMP	RSI, byte 0	   ; sedond str to copy is NULL ?
	JE	_strncmp_end	 ; yes ? go end

_strncmp_next:

  MOV R10B, byte [RDI + RCX]  ; use of temporrary memory to compare
  MOV R11B, byte [RSI + RCX]  ; use of temporrary memory to compare

  CMP R10B, R11B     ; is sring still same we?
  JNE _strcmp_final   ; no, go to end

  CMP R11B, byte 0   ; is searched string end yet?
  JE  _strcmp_final   ; yes, go to end

  CMP R10B, byte 0   ; is searched string end yet?
  JE  _strcmp_final   ; yes, go to end

  INC RCX            ; move to next char

  CMP RCX, RDX       ; size given fully checked ?
  JE  _strcmp_final   ; yes, end
  JMP _strncmp_next  ; repeat

_strcmp_final:

  SUB R10B, R11B     ; difference of the two last value before end
  MOVSX RAX, R10B    ; RAX set to difference between RDI and RSI
  JMP _strncmp_end

_strncmp_zero:

  MOV RAX, 0

_strncmp_end:

  POP RCX            ; restore rcx
  RET