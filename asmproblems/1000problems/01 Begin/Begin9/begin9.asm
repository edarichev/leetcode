; Begin9. Даны два неотрицательных числа a и b. Найти их среднее геометрическое, 
; то есть квадратный корень из их произведения: sqrt(a ⋅ b) .
;
; Вывод:
; a=9, b=4, m=6
extern  printf
section .data
        a       dq      9.0
        b       dq      4.0
        strFormat       db      "a=%g, b=%g, m=%g",10,0
section .bss
        m       resq    1       ; переменная для хранения результата
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [a]
        mulsd   xmm0, [b]
        sqrtsd  xmm0, xmm0
        movsd   [m], xmm0
        
        ; выводим
        movsd   xmm0, [a]
        movsd   xmm1, [b]
        movsd   xmm2, [m]
        mov     rax, 3          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
