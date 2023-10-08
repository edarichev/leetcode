; Begin8. Даны два числа a и b. Найти их среднее арифметическое: (a + b)/2.
;
; Вывод:
; a=3, b=7, m=5
extern  printf
section .data
        a       dq      3.0
        b       dq      7.0
        strFormat       db      "a=%g, b=%g, m=%g",10,0
section .bss
        m       resq    1       ; переменная для хранения результата
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [a]
        addsd   xmm0, [b]
        mov     rax, 2
        cvtsi2sd xmm1, rax
        divsd   xmm0, xmm1
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
