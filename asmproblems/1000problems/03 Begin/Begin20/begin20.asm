; Begin20. Найти расстояние между двумя точками с заданными координатами
; ( x 1 , y 1 ) и ( x 2 , y 2 ) на плоскости. Расстояние вычисляется по формуле
; sqrt (( x 2 − x 1 ) ^2 + ( y 2 − y 1 ) ^2 ).
;
; Вывод:
; (-9, 4); (-3, 8); L=7.2111
extern  printf
section .data
        x1      dq      -9.0
        y1      dq      4.0
        x2      dq      -3.0
        y2      dq      8.0
        strFormat       db      "(%g, %g); (%g, %g); L=%g",10,0
section .bss
        L       resq    1       ; переменная для |a|
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; dx
        movsd   xmm0, [x2]
        subsd   xmm0, [x1]
        mulsd   xmm0, xmm0      ; dx ^2
        ; dy
        movsd   xmm1, [y2]
        subsd   xmm1, [y1]
        mulsd   xmm1, xmm1      ; dx ^2
        ; dx^2 + dy^2
        addsd   xmm0, xmm1
        ; корень
        sqrtsd  xmm0, xmm0
        movsd   [L], xmm0

        ; выводим
        movsd   xmm0, [x1]
        movsd   xmm1, [y1]
        movsd   xmm2, [x2]
        movsd   xmm3, [y2]
        movsd   xmm4, [L]
        mov     rax, 5          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
