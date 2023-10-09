; Begin12. Даны катеты прямоугольного треугольника a и b . Найти его гипотенузу c и периметр P :
; c = sqrt(a^2 + b^2),
; P = a + b + c .
;
; Вывод:
; a=3, b=4, c=5, P=12
extern  printf
section .data
        a       dq      3.0
        b       dq      4.0
        strFormat       db      "a=%g, b=%g, c=%g, P=%g",10,0
section .bss
        c       resq    1       ; гипотенуза
        P       resq    1       ; периметр
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [a]
        mulsd   xmm0, xmm0      ; a^2

        movsd   xmm1, [b]
        mulsd   xmm1, xmm1      ; b^2
        
        addsd   xmm0, xmm1      ; a^2+b^2
        sqrtsd  xmm0, xmm0      ; c=sqrt -> xmm0
        movsd   [c], xmm0
        
        ; P=a+b+c
        addsd   xmm0, [a]
        addsd   xmm0, [b]
        movsd   [P], xmm0
        
        ; выводим
        movsd   xmm0, [a]
        movsd   xmm1, [b]
        movsd   xmm2, [c]
        movsd   xmm3, [P]
        mov     rax, 4          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
