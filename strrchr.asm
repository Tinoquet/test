BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL _strrchr ; Export 'strrchr'
_strrchr:

  PUSH  RCX                 ; save and clear out counter
  XOR   RCX, RCX
  XOR   R9, R9
	CMP	  RDI, byte 0         ; first str to compare is NULL ?
	JE	  _strrchr_end	  ; yes ? go end 

_strrchr_next:

  CMP byte [RDI + RCX], byte 0  ; is string end yet?
  JE  _strrchr_end              ; return 0

  CMP byte [RDI + RCX], SIL     ; is char we look for?
  JE  _strrchr_same             ; yes, go retrurn pointer

  INC RCX                       ; move to next char
  JMP _strrchr_next             ; repeat

_strrchr_same:
  
  MOV R9, RCX                 ; save last pos of the char to find found
  INC RCX
  JMP _strrchr_next

_strrchr_end:

  ADD RDI, R9
  MOV RAX, RDI                   ; put last saved pos of to find char in RAX
  POP RCX
  RET
