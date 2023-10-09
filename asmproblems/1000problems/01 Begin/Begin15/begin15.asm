; Begin15. Дана площадь S круга. Найти его диаметр D и длину L окружности,
; ограничивающей этот круг, учитывая, что L = π · D , S = π · D^2 /4. В качестве
; значения π использовать 3.14.
;
; Вывод:
; 
extern  printf
section .data
        S       dq      9.0
        PI      dq      3.14
        strFormat       db      "S=%g, D=%g, L=%g",10,0
section .bss
        D       resq    1
        L       resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; D = sqrt(4*S/PI)
        mov     rax, 4
        cvtsi2sd xmm0, rax
        mulsd   xmm0, [S]
        movsd   xmm1, [PI]      ; PI->xmm1, ещё пригодится
        divsd   xmm0, xmm1
        sqrtsd  xmm0, xmm0
        movsd   [D], xmm0       ; D -> xmm0
        
        ; L = PI*D
        mulsd   xmm0, xmm1      ; D (xmm0) * PI (xmm1)
        movsd   [L], xmm0
        
        ; выводим
        movsd   xmm0, [S]
        movsd   xmm1, [D]
        movsd   xmm2, [L]
        mov     rax, 3          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
