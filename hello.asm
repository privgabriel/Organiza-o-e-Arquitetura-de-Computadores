section .data
    message db "Hello, World!", 0Ah  ; Mensagem e nova linha
    msg_len equ $ - message          ; Comprimento da mensagem

section .text
    global _start                    ; Ponto de entrada

_start:
    ; sys_write (chamada de sistema para escrever)
    mov eax, 4                       ; syscall number (sys_write)
    mov ebx, 1                       ; file descriptor (stdout)
    mov ecx, message                 ; endereço da mensagem
    mov edx, msg_len                 ; comprimento da mensagem
    int 0x80                         ; chamada de sistema

    ; sys_exit (sair do programa)
    mov eax, 1                       ; syscall number (sys_exit)
    xor ebx, ebx                     ; código de saída 0
    int 0x80                         ; chamada de sistema
