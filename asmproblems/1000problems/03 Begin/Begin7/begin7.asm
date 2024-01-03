; Найти длину окружности L и площадь круга S заданного радиуса R:
; L = 2·π·R,
; S = π·R^2 .
; В качестве значения π использовать 3.14.
;
; Вывод:
; R=4, L=25.12, S=50.24
extern  printf
section .data
        PI      dq      3.14
        R       dq      4.0
        strFormat       db      "R=%g, L=%g, S=%g",10,0
section .bss
        L       resq    1       ; переменная для хранения длины окружности
        S       resq    1       ; переменная для хранения площади
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rax, 2
        cvtsi2sd xmm0, rax      ; 2 -> 2.0
        movsd   xmm1, [R]       ; перенести R в регистр
        movsd   xmm3, xmm1      ; копия R в xmm3, он понадобится ещё раз
        movsd   xmm2, [PI]      ; тоже в регистр, чтоб два раза не читать
        mulsd   xmm1, xmm2      ; pi*R -> xmm1 - это повторяется в обоих формулах
        mulsd   xmm0, xmm1      ; 2*pi*R
        movsd   [L], xmm0       ; сохр. L
        
        mulsd   xmm1, xmm3      ; pi*R * R
        movsd   [S], xmm1
        
        ; выводим
        movsd   xmm0, [R]
        movsd   xmm1, [L]
        movsd   xmm2, [S]
        mov     rax, 3          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
