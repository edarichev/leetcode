; Begin10. Даны два ненулевых числа. Найти сумму, разность, произведение и частное их квадратов.
;
; Вывод:
; a=9, b=4, m=6
extern  printf
section .data
        a       dq      9.0
        b       dq      4.0
        strFormat       db      "a=%g, b=%g, a^2=%g, b^2=%g, (a^2 + b^2)=%g, (a^2 - b^2)=%g, (a^2 * b^2)=%g, (a^2 / b^2)=%g",10,0
section .bss
        a2      resq    1       ; переменная для a^2
        b2      resq    1       ; переменная для b^2
        sums    resq    1       ; сумма квадратов
        subs    resq    1       ; разность квадратов
        muls    resq    1       ; произведение квадратов
        divs    resq    1       ; частное квадратов
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; квадрат a
        movsd   xmm0, [a]       ; сохраним a^2 в xmm0
        mulsd   xmm0, xmm0
        movsd   [a2], xmm0
        ; квадрат b
        movsd   xmm1, [b]       ; сохраним b^2 в xmm1
        mulsd   xmm1, xmm1
        movsd   [b2], xmm1
        
        ; сумма квадратов
        movsd   xmm2, xmm0
        addsd   xmm2, xmm1
        movsd   [sums], xmm2
        
        ; разность квадратов
        movsd   xmm2, xmm0
        subsd   xmm2, xmm1
        movsd   [subs], xmm2
        
        ; произведение квадратов
        movsd   xmm2, xmm0
        mulsd   xmm2, xmm1
        movsd   [muls], xmm2
        
        ; частное квадратов
        movsd   xmm2, xmm0
        divsd   xmm2, xmm1
        movsd   [divs], xmm2
        
        ; выводим
        movsd   xmm0, [a]
        movsd   xmm1, [b]
        movsd   xmm2, [a2]
        movsd   xmm3, [b2]
        movsd   xmm4, [sums]
        movsd   xmm5, [subs]
        movsd   xmm6, [muls]
        movsd   xmm7, [divs]
        mov     rax, 8          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
