; Proc57 . Используя функцию Leng из задания Proc56, описать функцию
; Perim( x A , y A , x B , y B , x C , y C ) вещественного типа, находящую периметр 
; треугольника ABC по координатам его вершин ( x A , y A , x B , y B , x C , y C — 
; вещественные параметры). С помощью этой функции найти периметры 
; треугольников ABC , ABD , ACD , если даны координаты точек A , B , C , D .
;
; Вывод:
; 5.23607

extern  printf

%macro  CALL_PERIM 6
        movsd   xmm0, [%1]
        movsd   xmm1, [%2]
        movsd   xmm2, [%3]
        movsd   xmm3, [%4]
        movsd   xmm4, [%5]
        movsd   xmm5, [%6]
        call    Perim
        
        mov     rax, 1
        mov     rdi, strFormat
        call    printf
%endm

section .data
        XA                      dq      1.0
        YA                      dq      1.0
        XB                      dq      1.0
        YB                      dq      2.0
        XC                      dq      3.0
        YC                      dq      2.0
        XD                      dq      3.0
        YD                      dq      1.0
        strFormat               db      "%g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        CALL_PERIM       XA, YA, XB, YB, XC, YC
exit:
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
%macro  PUSH_XMMS        0
        sub     rsp, 8
        movq    qword [rsp], xmm0
        sub     rsp, 8
        movq    qword [rsp], xmm1
        sub     rsp, 8
        movq    qword [rsp], xmm2
        sub     rsp, 8
        movq    qword [rsp], xmm3
        sub     rsp, 8
        movq    qword [rsp], xmm4
        sub     rsp, 8
        movq    qword [rsp], xmm5
        sub     rsp, 8
        movq    qword [rsp], xmm7
        sub     rsp, 8
%endm

%macro  POP_XMMS        0
        add     rsp, 8
        movq    xmm7, qword [rsp]
        add     rsp, 8
        movq    xmm5, qword [rsp]
        add     rsp, 8
        movq    xmm4, qword [rsp]
        add     rsp, 8
        movq    xmm3, qword [rsp]
        add     rsp, 8
        movq    xmm2, qword [rsp]
        add     rsp, 8
        movq    xmm1, qword [rsp]
        add     rsp, 8
        movq    xmm0, qword [rsp]
        add     rsp, 8
%endm
Perim:
        ; Вход: xmm0-xmm6, ( x A , y A , x B , y B , x C , y C )
        ; Выход: xmm0
        push    rbp
        mov     rbp, rsp
        pxor    xmm7, xmm7
        
        PUSH_XMMS
        call    Leng
        movq    xmm6, xmm0
        POP_XMMS
        addsd   xmm7, xmm6

        PUSH_XMMS
        movq    xmm2, xmm4
        movq    xmm3, xmm5
        call    Leng
        movq    xmm6, xmm0
        POP_XMMS
        addsd   xmm7, xmm6
        
        PUSH_XMMS
        movq    xmm0, xmm2
        movq    xmm1, xmm3
        movq    xmm2, xmm4
        movq    xmm3, xmm5
        call    Leng
        movq    xmm6, xmm0
        POP_XMMS
        addsd   xmm7, xmm6
        movq    xmm0, xmm7
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
