; Begin5. Дана длина ребра куба a. Найти объем куба V = a^3 и площадь его поверхности S = 6·a^2 .
;
; Вывод:
; a=3, V=27, S=54
extern  printf
section .data
        a       dq      3.0
        strFormat       db      "a=%g, V=%g, S=%g",10,0
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
        mulsd   xmm0, xmm0      ; a^2
        movsd   xmm1, xmm0      ; сохраним a^2 для площади
        mulsd   xmm0, [a]       ; a^3
        movsd   [V], xmm0
        
        ; S
        mov     rax, 6          ; Целое 6 преобразуем в double
        cvtsi2sd xmm0, rax      ; 6 -> 6.0
        mulsd   xmm0, xmm1      ; в xmm1 - a^2
        movsd   [S], xmm0
        
        ; выводим
        movsd   xmm0, [a]
        movsd   xmm1, [V]
        movsd   xmm2, [S]
        mov     rax, 3          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
