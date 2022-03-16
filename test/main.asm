BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL _start ; Export ’main’
EXTERN memset ; Import 'strlen' => replace by whatever function you wanna test
EXTERN strlen
_start :
  PUSH RBP ; Prologue :
  MOV RBP, RSP ; Stack frame setup
  MOV RDX, 6
  PUSH RDX
  MOV RSI, 45
  PUSH RSI
  MOV RDI, str ; First parameter
  PUSH RDI
  CALL memset ; Function Call : strlen(str) => replace by whatever function you wanna test
  MOV RDI, RAX ; Put the return value of strlen in RDI
  PUSH RDI
  CMP RDI, 0
  jz _ltr_not_found
_ltr_found :
  CALL strlen
  MOV RDX, RAX ; Third parameter
  MOV RSI, RDI ; Second parameter
  MOV RDI, 1 ; First parameter
  MOV RAX, 1 ; write() syscall number
  SYSCALL ; System call : write()
_ltr_not_found : 
  MOV RDI, RAX
  MOV RAX, 60 ; exit() syscall number
  SYSCALL ; System call : exit(RDI)
  LEAVE ; Epilogue
  RET ; Return
SECTION .rodata ; Read
str: DB 'almost every programmer should know memset!'; Test string
err: DB 'letter not found', 0Ah, 0             ; error string