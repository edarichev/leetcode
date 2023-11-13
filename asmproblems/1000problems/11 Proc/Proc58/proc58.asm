; Proc58 . Используя функции Leng и Perim из заданий Proc56 и Proc57, описать
; функцию Area( x A , y A , x B , y B , x C , y C ) вещественного типа, находящую площадь треугольника ABC по формуле
; S ABC = SQRT(p ⋅ ( p − AB ) ⋅ ( p − AC ) ⋅ ( p − BC )),
; где p — полупериметр . С помощью этой функции найти площади треугольников ABC , ABD , ACD , если даны координаты точек A , B , C , D .
;
; Вывод:
; 1.5

extern  printf

%macro  CALL_AREA 6
        movsd   xmm0, [%1]
        movsd   xmm1, [%2]
        movsd   xmm2, [%3]
        movsd   xmm3, [%4]
        movsd   xmm4, [%5]
        movsd   xmm5, [%6]
        call    Area
        
        mov     rax, 1
        mov     rdi, strFormat
        call    printf
%endm

section .data
        XA                      dq      1.0
        YA                      dq      1.0
        XB                      dq      1.0
        YB                      dq      2.0
        XC                      dq      4.0
        YC                      dq      2.0
        XD                      dq      4.0
        YD                      dq      1.0
        strFormat               db      "%g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        CALL_AREA       XA, YA, XB, YB, XC, YC
exit:
        leave
        ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Area:
        ; Вход: xmm0-xmm6, ( x A , y A , x B , y B , x C , y C )
        ; Выход: xmm0
        ; SQRT(p ⋅ ( p − AB ) ⋅ ( p − AC ) ⋅ ( p − BC )),
section .bss
        xa      resq    1
        ya      resq    1
        xb      resq    1
        yb      resq    1
        xc      resq    1
        yc      resq    1
        p       resq    1
        ab      resq    1
        ac      resq    1
        bc      resq    1
section .text
        push    rbp
        mov     rbp, rsp
        
        movsd   [xa], xmm0
        movsd   [ya], xmm1
        movsd   [xb], xmm2
        movsd   [yb], xmm3
        movsd   [xc], xmm4
        movsd   [yc], xmm5
        
        call    Perim
        mov     rax, 2
        cvtsi2sd xmm1, rax
        divsd   xmm0, xmm1
        movsd   [p], xmm0
        
        movsd   xmm0, [xa]
        movsd   xmm1, [ya]
        movsd   xmm2, [xb]
        movsd   xmm3, [yb]
        call    Leng
        movsd   [ab], xmm0
        
        movsd   xmm0, [xa]
        movsd   xmm1, [ya]
        movsd   xmm2, [xc]
        movsd   xmm3, [yc]
        call    Leng
        movsd   [ac], xmm0
        
        movsd   xmm0, [xb]
        movsd   xmm1, [yb]
        movsd   xmm2, [xc]
        movsd   xmm3, [yc]
        call    Leng
        movsd   [bc], xmm0
        
        movsd   xmm1, [p]
        movsd   xmm0, xmm1

        movsd   xmm2, xmm1
        subsd   xmm2, [ab]
        mulsd   xmm0, xmm2
        
        movsd   xmm2, xmm1
        subsd   xmm2, [ac]
        mulsd   xmm0, xmm2
        
        movsd   xmm2, xmm1
        subsd   xmm2, [bc]
        mulsd   xmm0, xmm2
        
        sqrtsd  xmm0, xmm0
        
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
