; Proc4 ° . Описать процедуру TrianglePS( a , P , S ), вычисляющую по стороне a
; равностороннего треугольника его периметр P = 3· a и площадь S = a^2 3 / 4
; ( a — входной, P и S — выходные параметры; все параметры являются 
; вещественными). С помощью этой процедуры найти периметры и площади
; трех равносторонних треугольников с данными сторонами.
;
; Вывод:
; a = 1, P = 3, S = 0.75
; a = 2, P = 6, S = 3
; a = 3, P = 9, S = 6.75

extern  printf

%macro  print_xmm 0
        mov     rax, 3
        mov     rdi, strFormat
        call    printf
%endmacro

section .data
        A               dq      1.0
        B               dq      2.0
        C               dq      3.0
        strFormat       db      "a = %g, P = %g, S = %g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [A]
        call    TrianglePS
        print_xmm
        
        movsd   xmm0, [B]
        call    TrianglePS
        print_xmm

        movsd   xmm0, [C]
        call    TrianglePS
        print_xmm
        
        leave
        ret

TrianglePS:
        ; TrianglePS
        ; Вход: xmm0 - сторона треугольника a, double
        ; Выход: xmm1 - P, double
        ;        xmm2 - S, double
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        mov     rax, 3
        cvtsi2sd xmm3, rax      ; <- 3.0
        movsd   xmm1, xmm0
        mulsd   xmm1, xmm3      ; P=3a
        
        movsd   xmm2, xmm1      ; 3a уже есть, зачем считать
        mulsd   xmm2, xmm0      ; 3a^2
        mov     rax, 4
        cvtsi2sd xmm4, rax      ; <- 4.0
        divsd   xmm2, xmm4      ; S=3a^2/4
        
        leave
        ret
