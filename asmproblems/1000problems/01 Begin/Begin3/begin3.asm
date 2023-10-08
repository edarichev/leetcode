; Begin3°. Даны стороны прямоугольника a и b. Найти его площадь S = a·b и периметр P = 2·(a + b).
;
; Вывод:
; a=1.5, b=2, S=3, P=7
extern  printf
section .data
        a       dq      1.5     ; сторона a
        b       dq      2.0     ; сторона b
        strFormat       db      "a=%g, b=%g, S=%g, P=%g",10,0
section .bss
        S       resq    1       ; переменная для хранения площади
        P       resq    1       ; переменная для хранения периметра
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; площадь
        movsd   xmm0, [a]       ; сторона a
        movsd   xmm1, [b]       ; сторона b
        mulsd   xmm0, xmm1      ; S=a*b
        movsd   [S], xmm0       ; сохраним во временную переменную S, хотя и не требуется
        ; периметр
        movsd   xmm0, [a]
        movsd   xmm1, [b]
        addsd   xmm0, xmm1      ; a+b
        mov     rax, 2          ; 2
        cvtsi2sd xmm1, rax      ; 2->2.0
        mulsd   xmm0, xmm1      ; 2.0*(a+b)
        movsd   [P], xmm0
        
        ; выводим
        movsd   xmm0, [a]
        movsd   xmm1, [b]
        movsd   xmm2, [S]
        movsd   xmm3, [P]
        mov     rax, 4          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
