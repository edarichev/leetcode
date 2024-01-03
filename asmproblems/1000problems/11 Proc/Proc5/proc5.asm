; Proc5 . Описать процедуру RectPS( x 1 , y 1 , x 2 , y 2 , P , S ), вычисляющую периметр P
; и площадь S прямоугольника со сторонами, параллельными осям координат, 
; по координатам ( x 1 , y 1 ), ( x 2 , y 2 ) его противоположных вершин ( x 1 , y 1 ,
; x 2 , y 2 — входные, P и S — выходные параметры вещественного типа).
; С помощью этой процедуры найти периметры и площади трех прямоугольников с данными противоположными вершинами.
;
; Вывод:
; (1, 2), (3, 4): P = 8, S = 4
; (10, 12), (15, 14): P = 14, S = 10
; (2, 12), (23, 26): P = 70, S = 294

extern  printf

%macro  call_RectPS 4
        movsd   xmm0, [%1]
        movsd   xmm1, [%2]
        movsd   xmm2, [%3]
        movsd   xmm3, [%4]
        call    RectPS
%endmacro

%macro  print_xmm 0
        mov     rax, 6
        mov     rdi, strFormat
        call    printf
%endmacro

section .data
        x1_a            dq      1.0
        y1_a            dq      2.0
        x2_a            dq      3.0
        y2_a            dq      4.0
        
        x1_b            dq      10.0
        y1_b            dq      12.0
        x2_b            dq      15.0
        y2_b            dq      14.0
        
        x1_c            dq      2.0
        y1_c            dq      12.0
        x2_c            dq      23.0
        y2_c            dq      26.0
        strFormat       db      "(%g, %g), (%g, %g): P = %g, S = %g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        call_RectPS     x1_a, y1_a, x2_a, y2_a
        print_xmm
        
        call_RectPS     x1_b, y1_b, x2_b, y2_b
        print_xmm
        
        call_RectPS     x1_c, y1_c, x2_c, y2_c
        print_xmm
        
        leave
        ret

RectPS:
        ; RectPS
        ; Вход: (xmm0, xmm1), (xmm2, xmm3) === (x1,y1), (x2, y2) соответственно, double
        ; Выход: xmm4 - P, double
        ;        xmm5 - S, double
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm7, xmm0      ; xmm7 == dx
        subsd   xmm7, xmm2      ; dx=x2-x1
        movq    rax, xmm7
        btr     rax, 63         ; IEEE 754, старший бит знаковый, сбросим его
        movq    xmm7, rax       ; |dx|
        
        movsd   xmm6, xmm1      ; xmm6 == dy
        subsd   xmm6, xmm3      ; dy=y2-y1
        movq    rax, xmm6
        btr     rax, 63
        movq    xmm6, rax       ; |dy|
        
        movsd   xmm4, xmm6      ; просто сложим, по сложности меньше, чем преобразование 2->2.0 и mulsd
        addsd   xmm4, xmm7
        addsd   xmm4, xmm6
        addsd   xmm4, xmm7      ; P
        
        movsd   xmm5, xmm7
        mulsd   xmm5, xmm6      ; S
        
        leave
        ret
