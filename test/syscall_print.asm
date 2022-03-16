BITS 64 ; 64−bit mode
SECTION .text ; Code section
GLOBAL putstr ; Export ’main’
putstr :
PUSH RBP ; Prologue :
MOV RBP, RSP ; Stack frame setup
MOV RAX, 1 ; write() syscall number
MOV RDX, 29 ; Third parameter
MOV RSI, str ; Second parameter
MOV RDI, 1 ; First parameter
SYSCALL ; System call : write()
MOV RAX, 60 ; exit() syscall number
XOR RDI, RDI ; RDI = 0 (first parameter)
SYSCALL ; System call : exit(0)
LEAVE ; Epilogue
RET ; Return
SECTION .rodata ; Read
str: DB 'Heh..... HEH !! HELLO WORLD !', 0Ah, 0 ; Format string for printf()SP, RBP