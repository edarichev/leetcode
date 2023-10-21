; Дано целое число N (> 0). Найти сумму
; N^2 + ( N + 1)^2 + ( N + 2)^2 + ... + (2· N )^2
; (целое число).
;
; Вывод:
; 10
;  ∑(i+N)^2 = 6985
; i=0

extern  printf
section .data
        A               equ     0
        B               equ     10
        N               equ     20
        strFormat       db      "%3d",10,"  ∑(i+N)^2 = %d",10, " i=%d",10 0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, A          ; счётчик
        mov     rbx, B          ; верхняя граница
        xor     rdx, rdx        ; сумма
for_loop:
        cmp     rcx, rbx
        jg      done
        mov     rax, N
        add     rax, rcx
        imul    rax, rax
        add     rdx, rax
        inc     rcx
        jmp     for_loop
done:
        mov     rax, 0
        mov     rdi, strFormat
        mov     rsi, B
        mov     rcx, A
        call    printf
        
        leave
        ret
