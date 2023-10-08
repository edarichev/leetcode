; Begin4. Дан диаметр окружности d. Найти ее длину L = π·d. В качестве значения π использовать 3.14.
;
; Вывод:
; L=pi*3.2=10.048
extern  printf
section .data
        PI      dq      3.14
        d       dq      3.2
        strFormat       db      "L=pi*%g=%g",10,0
section .bss
        L       resq    1       ; переменная для хранения длины окружности
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [PI]
        mulsd   xmm0, [d]       ; pi*d
        movsd   [L], xmm0
        
        ; выводим
        movsd   xmm0, [d]
        movsd   xmm1, [L]
        mov     rax, 2          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
