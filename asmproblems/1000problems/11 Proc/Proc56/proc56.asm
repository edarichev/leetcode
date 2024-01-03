; Proc56 . Описать функцию Leng( x A , y A , x B , y B ) вещественного типа, находящую
; длину отрезка AB на плоскости по координатам его концов:
; | AB | = SQRT(( x A − x B )^2 + ( y A − y B )^2)
; ( x A , y A , x B , y B — вещественные параметры). С помощью этой функции найти 
; длины отрезков AB , AC , AD , если даны координаты точек A , B , C , D .
;
; Вывод:
; 1.41421
; 2
; 3

extern  printf

%macro  CALL_LENG 4
        movsd   xmm0, [%1]
        movsd   xmm1, [%2]
        movsd   xmm2, [%3]
        movsd   xmm3, [%4]
        call    Leng
        
        mov     rax, 1
        mov     rdi, strFormat
        call    printf
%endm

section .data
        XA                      dq      1.0
        YA                      dq      1.0
        XB                      dq      2.0
        YB                      dq      2.0
        XC                      dq      3.0
        YC                      dq      1.0
        XD                      dq      4.0
        YD                      dq      1.0
        strFormat               db      "%g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        CALL_LENG       XA, YA, XB, YB
        CALL_LENG       XA, YA, XC, YC
        CALL_LENG       XA, YA, XD, YD
exit:
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Leng:
        ; Вход: xmm0 - x A , xmm1 - y A , xmm2 - x B , xmm3 - y B
        ; Выход: xmm0
        push    rbp
        mov     rbp, rsp
        
        subsd   xmm0, xmm2
        mulsd   xmm0, xmm0
        
        subsd   xmm1, xmm3
        mulsd   xmm1, xmm1
        
        addsd   xmm0, xmm1
        sqrtsd  xmm0, xmm0
        
        leave
        ret
