BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL _strchr ; Export 'strchr'
_strchr:

	CMP	  RDI, byte 0     ; first str to compare is NULL ?
	JE	  _strchr_not_found	  ; yes ? go end 

_strchr_next:

  CMP byte [RDI], SIL     ; is char we look for?
  JE  _strchr_same        ; yes, go retrurn pointer

  CMP byte [RDI], byte 0  ; is string end yet?
  JE  _strchr_not_found   ; return 0

  INC RDI            ; move to next char
  JMP _strchr_next   ; repeat

_strchr_same:

  MOV RAX, RDI       ; RDI = the pointer of search char (put in rax)
  RET

_strchr_not_found:

  MOV RAX, 0         ; RDI = 0 char not found (put in rax)
  RET