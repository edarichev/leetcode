; Proc20 . Описать функцию TriangleP( a , h ), находящую периметр равнобедренного 
; треугольника по его основанию a и высоте h , проведенной к основанию 
; ( a и h — вещественные). С помощью этой функции найти периметры
; трех треугольников, для которых даны основания и высоты. Для нахождения 
; боковой стороны b треугольника использовать теорему Пифагора :
; b^2 = ( a /2)^2 + h^2 .
;
; Вывод:
; a=1, h=2, P=5.12311
; a=3, h=4, P=11.544
; a=2, h=6, P=14.1655

extern  printf
section .data
        A1              dq      1.0
        H1              dq      2.0
        A2              dq      3.0
        H2              dq      4.0
        A3              dq      2.0
        H3              dq      6.0
        strFormat       db      "a=%g, h=%g, P=%g",10,0
section .bss
        S               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        ; 1
        movsd   xmm0, [A1]
        movsd   xmm1, [H1]
        call    TriangleP
        movsd   xmm2, xmm0
        movsd   xmm0, [A1]
        movsd   xmm1, [H1]
        mov     rax, 3
        mov     rdi, strFormat
        call    printf
        
        ; 2
        movsd   xmm0, [A2]
        movsd   xmm1, [H2]
        call    TriangleP
        movsd   xmm2, xmm0
        movsd   xmm0, [A2]
        movsd   xmm1, [H2]
        mov     rax, 3
        mov     rdi, strFormat
        call    printf
        
        ; 3
        movsd   xmm0, [A3]
        movsd   xmm1, [H3]
        call    TriangleP
        movsd   xmm2, xmm0
        movsd   xmm0, [A3]
        movsd   xmm1, [H3]
        mov     rax, 3
        mov     rdi, strFormat
        call    printf
        leave
        ret

TriangleP:
        ; Вход: xmm0 - a, xmm1 - h
        ; Выход: xmm0: P
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp

        ; b^2 = ( a /2)^2 + h^2 .
        mov     rax, 2
        cvtsi2sd xmm2, rax      ; 2.0 <- 2
        movsd   xmm3, xmm0
        divsd   xmm3, xmm2      ; a/2
        mulsd   xmm3, xmm3      ; (a/2)^2
        movsd   xmm4, xmm1
        mulsd   xmm4, xmm4      ; h^2
        addsd   xmm3, xmm4      ; == b^2
        sqrtsd  xmm3, xmm3      ; == b
        addsd   xmm0, xmm3      ; a+b
        addsd   xmm0, xmm3      ; P=a+b+b, т.к. равнобедренный

        leave
        ret
