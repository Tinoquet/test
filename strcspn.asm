BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL _strcspn ; Export 'strcspn'
_strcspn:

  PUSH  RCX                  ; save and clear out counter
  XOR   RCX, RCX
  XOR   R9, R9               ; set R9 to 0
  CMP	RDI, byte 0          ; first str to compare is NULL ?
  JE	_strcspn_end	 ; yes ? go end 
  CMP	RSI, byte 0	         ; sedond str to copy is NULL ?
  JE	_strcspn_end	 ; yes ? go end
  MOV R10B, byte [RDI + RCX]

_strcspn_next:

  MOV R11B, byte [RSI + R9]

  CMP R11B, byte 0        ; is searched string end yet?
  JE  _strcspn_not_found  ; yes, go advance RDI and reset RCX

  CMP R10B, R11B          ; is first str same as one of second str char ?
  JE _strcspn_end       ; yes, go to end

  INC R9                  ; advance to next letter in second str
  JMP _strcspn_next       ; repeat

_strcspn_not_found:

  XOR R9, R9            ; reset to find pointer
  INC RCX
  MOV R10B, byte [RDI + RCX]
  
  CMP R10B, byte 0        ; is to find string end yet?
  JE  _strcspn_end    ; yes, go to end
  JMP _strcspn_next       ; goes back to loop

_strcspn_end:

  MOV RAX, RCX            ; RDI = pointer to first char of to find string (put in rax)
  POP RCX                 ; restore RCX
  RET
