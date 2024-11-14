section .data
    pergunta db "Como você se chama?", 10  ; Mensagem com nova linha
    tamPerg equ $-pergunta                 ; Tamanho da mensagem

    ola db "Olá ", 0                       ; Saudação com espaço após "Olá"

section .bss
    nome resb 10                           ; Buffer para armazenar o nome do usuário

section .text
    global _start

_start:
    ; Imprimindo a pergunta
    mov rax, 1         ; syscall write
    mov rdi, 1         ; saída padrão (stdout)
    mov rsi, pergunta  ; ponteiro para a pergunta
    mov rdx, tamPerg   ; tamanho da pergunta
    syscall

    ; Lendo o nome do usuário
    mov rax, 0         ; syscall read
    mov rdi, 0         ; entrada padrão (stdin)
    mov rsi, nome      ; ponteiro para o buffer
    mov rdx, 10        ; tamanho máximo do nome
    syscall

    ; Remover o caractere '\n' ao final do nome, substituindo-o por terminador nulo
    mov rbx, nome      ; Carrega o endereço do buffer
    mov rcx, rax       ; rax contém o número de bytes lidos
    dec rcx            ; Aponta para o último byte lido
    mov byte [rbx + rcx], 0  ; Substitui o '\n' pelo terminador nulo

    ; Imprimindo "Olá "
    mov rax, 1         ; syscall write
    mov rdi, 1         ; saída padrão (stdout)
    mov rsi, ola       ; ponteiro para saudação
    mov rdx, 5         ; comprimento da saudação (incluindo espaço)
    syscall

    ; Imprimindo nome do usuário
    mov rax, 1         ; syscall write
    mov rdi, 1         ; saída padrão (stdout)
    mov rsi, nome      ; ponteiro para o nome
    mov rdx, rcx       ; comprimento do nome (rcx já ajustado)
    syscall

    ; Saindo do programa
    mov rax, 60        ; syscall exit
    xor rdi, rdi       ; código de saída 0
    syscall
