; Подсчет различных букв в слове
%include "../include/memset.inc"
extern  printf
section .data
    strText db  "packages",0
    nLength equ  $-strText-1
    strFormat   db  "Different charactes count: %d",10,0
    CHARS_COUNT equ 256
section .bss
    cCount  resb    1
    charMap resb    CHARS_COUNT
section .text
    global main
main:
    push    rbp
    mov     rbp, rsp
    
    mov al, 0
    mov [cCount], al
    ; заполним карту нулями: каждая позиция соответствует ASCII-коду
    ; в каждой ячейке - сколько раз встретился данный символ
    ; затем пройдёмся по всей карте и определим, сколько ненулевых ячеек
    mov     rdi, charMap
    mov     rsi, 0
    mov     rdx, CHARS_COUNT
    call    _memset
    
    mov     rcx, 0
    mov     rdx, strText
    xor     rax, rax
    xor     rbx, rbx
.loop:
    mov     al, [rdx]       ; след. символ из строки
    mov     bl, [charMap + rax]
    inc     bl
    mov     [charMap + rax], bl
    inc     rdx
    inc     rcx
    cmp     rcx, nLength
    jl      .loop
.done:
    ; подсчёт числа ненулевых частот символов
    xor     rax, rax
    mov     rbx, charMap
    mov     rcx, CHARS_COUNT
    xor     rdx, rdx
.loopcalc:
    mov     dl, [rbx]
    or      dl, dl
    jz      .next
    inc     rax
.next:
    inc     rbx
    dec     rcx
    jnz     .loopcalc
.exit:
    mov     rdi, strFormat
    mov     rsi, rax
    call    printf
    leave
    ret
    


