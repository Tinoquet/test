BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL _strcasecmp ; Export 'strcasecmp'
EXTERN tolower
_strcasecmp:

  PUSH  RCX                ; save and clear out counter
  XOR   RCX, RCX
  CMP	RDI, byte 0        ; first str to compare is NULL ?
  JE	_strcasecmp_end	   ; yes ? go end 
  CMP	RSI, byte 0	       ; second str to copy is NULL ?
  JE	_strcasecmp_end	   ; yes ? go end

_strcasecmp_loop:

  MOV  R10, [RDI + RCX] ; copy first str char in tmp
  PUSH R10
  CALL tolower           ; set it to lower case if not already
  POP  R10
  MOV  R10, RAX
  MOV  R11, [RSI + RCX] ; copy second str char in tmp 
  PUSH R11
  CALL tolower           ; set it to lower case if not already
  POP  R11
  MOV  R11, RAX

  MOV  R10B, byte [R10]
  MOV  R11B, byte [R11]

  CMP R10B, R11B         ; is sring still same we?
  JNE _strcasecmp_final  ; no, go to end

  CMP R11B, byte 0       ; is searched string end yet?
  JE  _strcasecmp_final  ; yes, go to end

  CMP R10B, byte 0       ; is searched string end yet?
  JE  _strcasecmp_final  ; yes, go to end

  INC RCX                ; move to next char
  JMP _strcasecmp_loop   ; repeat

_strcasecmp_final:

  SUB R10B, R11B     ; difference of the two last value before end
  MOVSX RAX, R10B    ; RAX set to difference between RDI and RSI

_strcasecmp_end:

  POP RCX            ; restore rcx
  RET