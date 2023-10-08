; Begin2. Дана сторона квадрата a. Найти его площадь S = a^2 .
;
; Вывод:
; S=23.3^2=542.89
extern  printf
section .data
        a       dq      23.3    ; сторона квадрата
        strFormat       db      "S=%g^2=%g",10,0
section .bss
        S       resq    1       ; переменная для хранения площади (необязательно)
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [a]       ; сторона квадрата
        mulsd   xmm0, xmm0      ; a*a
        movsd   [S], xmm0       ; сохраним во временную переменную S, хотя и не требуется
        
        movsd   xmm0, [a]
        movsd   xmm1, [S]
        mov     rax, 2          ; два вещественных числа
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
