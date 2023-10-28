; Begin14. Дана длина L окружности. Найти ее радиус R и площадь S круга, ограниченного 
; этой окружностью, учитывая, что L = 2· π · R , S = π · R^2 . 
; В качестве значения π использовать 3.14.
;
; Вывод:
; L=9, R=1.43312, S=6.44904
extern  printf
section .data
        PI      dq      3.14
        L       dq      9.0
        strFormat       db      "L=%g, R=%g, S=%g",10,0
section .bss
        R       resq    1       ; радиус
        S       resq    1       ; площадь круга
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; R = L/(2*PI)
        mov     rax, 2
        cvtsi2sd xmm0, rax      ; 2 -> 2.0
        mulsd   xmm0, [PI]
        movsd   xmm1, [L]
        divsd   xmm1, xmm0      ; R->xmm1
        movsd   [R], xmm1
        
        ; S = PI*R^2
        movsd   xmm0, [PI]
        mulsd   xmm0, xmm1      ; PI*R
        mulsd   xmm0, xmm1      ; PI*R^2
        movsd   [S], xmm0
        
        ; выводим
        movsd   xmm0, [L]
        movsd   xmm1, [R]
        movsd   xmm2, [S]
        mov     rax, 3          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
