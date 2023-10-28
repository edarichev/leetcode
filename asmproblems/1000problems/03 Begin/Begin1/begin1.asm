; Begin1. Дана сторона квадрата a. Найти его периметр P = 4·a.
;
; Вывод:
; P=4*23.3=93.2
extern  printf
section .data
        a       dq      23.3    ; сторона квадрата
        strFormat       db      "P=4*%g=%g",10,0
section .bss
        P       resq    1       ; переменная для хранения периметра (необязательно)
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [a]       ; сторона квадрата
        mov     rax, 4          ; ставим целое в rax
        cvtsi2sd xmm1, rax      ; преобразуем целое в rax в double в xmm1
        mulsd   xmm0, xmm1      ; a*4
        movsd   [P], xmm0       ; сохраним во временную переменную P, хотя и не требуется
        
        movsd   xmm0, [a]
        movsd   xmm1, [P]
        mov     rax, 2          ; два вещественных числа
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
