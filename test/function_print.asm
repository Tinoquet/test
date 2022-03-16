BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL main ; Export ’main’
EXTERN strlen ; Import 'strlen' => replace by whatever function you wanna test
main :
PUSH RBP ; Prologue :
MOV RBP, RSP ; Stack frame setup
MOV RDI, str ; First parameter
PUSH RDI
CALL strlen ; Function Call : strlen(str) => replace by whatever function you wanna test
MOV RDI, RAX ; Put the return value of strlen in RDI
MOV RAX, 60 ; exit() syscall number
SYSCALL ; System call : exit(RDI)
LEAVE ; Epilogue
RET ; Return
SECTION .rodata ; Read
str: DB 'Heh..... HEH !! HELLO WORLD !', 0Ah, 0 ; Test string