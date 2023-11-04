; Proc3 . Описать процедуру Mean( X , Y , AMean , GMean ), вычисляющую среднее
; арифметическое AMean = ( X + Y )/2 и среднее геометрическое GMean = SQRT(X ⋅ Y)
; двух положительных чисел X и Y ( X и Y — входные, AMean
; и GMean — выходные параметры вещественного типа). С помощью этой
; процедуры найти среднее арифметическое и среднее геометрическое для
; пар ( A , B ), ( A , C ), ( A , D ), если даны A , B , C , D .
;
; Вывод:
; (1, 2): AMean = 1.5, GMean = 1.41421
; (1, 3): AMean = 2, GMean = 1.73205
; (1, 4): AMean = 2.5, GMean = 2

extern  printf

%macro  print_xmm 0
        mov     rax, 4
        mov     rdi, strFormat
        call    printf
%endmacro

section .data
        A               dq      1.0
        B               dq      2.0
        C               dq      3.0
        D               dq      4.0
        strFormat       db      "(%g, %g): AMean = %g, GMean = %g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        call    Mean
        print_xmm
        
        movsd   xmm0, [A]
        movsd   xmm1, [C]
        call    Mean
        print_xmm

        movsd   xmm0, [A]
        movsd   xmm1, [D]
        call    Mean
        print_xmm
        
        leave
        ret

Mean:
        ; AMean, GMean
        ; Вход: xmm0 - число A, double
        ;       xmm1 - число B, double
        ; Выход: xmm2 - AMean, double
        ;        xmm3 - GMean, double
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm2, xmm0
        addsd   xmm2, xmm1
        mov     rax, 2
        cvtsi2sd xmm3, rax
        divsd   xmm2, xmm3      ; AMean
        
        movsd   xmm3, xmm0
        mulsd   xmm3, xmm1
        sqrtsd  xmm3, xmm3      ; GMean
        
        leave
        ret
