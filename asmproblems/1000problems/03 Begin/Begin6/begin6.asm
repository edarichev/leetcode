; Begin6. Даны длины ребер a, b, c прямоугольного параллелепипеда. Найти его
; объем V = a·b·c и площадь поверхности S = 2·(a·b + b·c + a·c).
;
; Вывод:
; a=3, b=4, c=5, V=60, S=94
extern  printf
section .data
        a       dq      3.0
        b       dq      4.0
        c       dq      5.0
        strFormat       db      "a=%g, b=%g, c=%g, V=%g, S=%g",10,0
section .bss
        V       resq    1       ; переменная для хранения объёма
        S       resq    1       ; переменная для хранения площади поверхности
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; V
        movsd   xmm0, [a]
        mulsd   xmm0, [b]
        mulsd   xmm0, [c]
        movsd   [V], xmm0
        
        ; S
        mov     rax, 2          ; Целое преобразуем в double
        cvtsi2sd xmm0, rax      ; 2 -> 2.0
        movsd   xmm1, [a]
        movsd   xmm2, [b]
        movsd   xmm3, [c]
        
        movsd   xmm4, xmm1
        mulsd   xmm4, xmm2      ; a*b
        
        movsd   xmm5, xmm2      ; b
        mulsd   xmm5, xmm3      ; b*c
        addsd   xmm4, xmm5      ; a*b+b*c
        
        movsd   xmm5, xmm1      ; a
        mulsd   xmm5, xmm3      ; a*c
        addsd   xmm4, xmm5      ; a*b+b*c+a*c
        
        mulsd   xmm0, xmm4
        
        movsd   [S], xmm0
        
        ; выводим
        movsd   xmm0, [a]
        movsd   xmm1, [b]
        movsd   xmm2, [c]
        movsd   xmm3, [V]
        movsd   xmm4, [S]
        mov     rax, 5          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
