BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL _strlen ; Export 'strlen'
_strlen:

  PUSH  RCX            ; save and clear out counter
  XOR   RCX, RCX

_strlen_next:

  CMP [RDI], byte 0  ; is string end yet?
  JZ  _strlen_null   ; yes, go to return

  INC RCX            ; char is not null, so add to count
  INC RDI            ; move to next char
  JMP _strlen_next   ; repeat

_strlen_null:

  MOV RAX, RCX       ; rcx = the length (put in rax)
  POP RCX            ; restore rcx
  RET