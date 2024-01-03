; While3 . Даны целые положительные числа N и K . Используя только операции
; сложения и вычитания, найти частное от деления нацело N на K , а также
; остаток от этого деления.
;
; Вывод:
; 14 / 3 = 4; 2
; 14 / 14 = 1; 0
; 14 / 15 = 0; 14

extern  printf
section .data
        N               equ     14
        K               equ     15
        strFormat       db      "%d / %d = %d; %d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; вычитаем, пока не уйдём в отрицательное число, затем прибавим K и уменьшим на 1 частное
        ; если же идти только до 0, то придётся делать ещё одно сравнение, что не выгодно
        mov     rax, N
        mov     rbx, K
        mov     rcx, 0          ; частное
loop_i:
        sub     rax, rbx
        inc     rcx
        cmp     rax, 0
        jnl     loop_i
result:
        add     rax, rbx        ; в любом случае был заход в отрицательную область,
        dec     rcx             ; поэтому коррекция
        
        mov     rsi, N
        mov     rdx, K
        ; rcx - это уже частное
        mov     r8, rax         ; остаток
        mov     rax, 0
        mov     rdi, strFormat
        
        call    printf
        leave
        ret
