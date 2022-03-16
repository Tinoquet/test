BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL _strstr ; Export 'strstr'
_strstr:

  PUSH  RCX                ; save and clear out counter
  XOR   RCX, RCX
	CMP	RDI, byte 0          ; first str to compare is NULL ?
	JE	_strstr_not_found	   ; yes ? go end 
	CMP	RSI, byte 0	         ; sedond str to copy is NULL ?
	JE	_strstr_not_found	   ; yes ? go end

_strstr_next:

  MOV R10B, byte [RDI + RCX]
  MOV R11B, byte [RSI + RCX]

  CMP R11B, byte 0        ; is to find string end yet?
  JE  _strstr_found       ; yes, go to end

  CMP R10B, byte 0        ; is searched string end yet?
  JE  _strstr_not_found   ; yes, go to end

  CMP R10B, R11B          ; is sring still same we?
  JNE _strstr_not_same    ; no, go advance RDI and reset RCX

  INC RCX                 ; advance to find pointer
  JMP _strstr_next        ; repeat

_strstr_not_same:

  INC RDI                 ; advance searched pointer
  XOR RCX, RCX            ; reset to find pointer
  JMP _strstr_next        ; goes back to loop

_strstr_found:

  MOV RAX, RDI            ; RDI = pointer to first char of to find string (put in rax)
  POP RCX                 ; restore RCX
  RET

_strstr_not_found:

  MOV RAX, 0              ; RAX get a nullptr (string to find not found)
  POP RCX                 ; restore RCX
  RET