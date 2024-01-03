; Proc1 . Описать процедуру PowerA3( A , B ), вычисляющую третью степень числа
; A и возвращающую ее в переменной B ( A — входной, B — выходной параметр; 
; оба параметра являются вещественными). С помощью этой процедуры
; найти третьи степени пяти данных чисел.
;
; Вывод:
; 1^3 = 1
; 2^3 = 8
; 3^3 = 27
; 4^3 = 64
; 5^3 = 125
extern  printf

%macro  xchg_xmm 2
        pxor    %1, %2
        pxor    %2, %1
        pxor    %1, %2
%endmacro

%macro  print_xmm01 1
        ; %1    строка формата
        mov     rax, 1
        mov     rdi, %1
        call    printf
%endmacro

section .data
        N1              dq      1.0
        N2              dq      2.0
        N3              dq      3.0
        N4              dq      4.0
        N5              dq      5.0
        strFormat       db      "%g^3 = %g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm1, [N1]
        movsd   xmm0, xmm1
        call    PowerA3
        xchg_xmm xmm0, xmm1
        print_xmm01(strFormat)

        movsd   xmm1, [N2]
        movsd   xmm0, xmm1
        call    PowerA3
        xchg_xmm xmm0, xmm1
        print_xmm01(strFormat)

        movsd   xmm1, [N3]
        movsd   xmm0, xmm1
        call    PowerA3
        xchg_xmm xmm0, xmm1
        print_xmm01(strFormat)
        
        movsd   xmm1, [N4]
        movsd   xmm0, xmm1
        call    PowerA3
        xchg_xmm xmm0, xmm1
        print_xmm01(strFormat)

        movsd   xmm1, [N5]
        movsd   xmm0, xmm1
        call    PowerA3
        xchg_xmm xmm0, xmm1
        print_xmm01(strFormat)

        leave
        ret

PowerA3:
        ; Третья степень
        ; Вход: xmm0 - число, double
        ; Выход: xmm0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        movq    xmm1, xmm0      ; копия исходного числа
        mulsd   xmm0, xmm1      ; ^2
        mulsd   xmm0, xmm1      ; ^3
        
        leave
        ret
