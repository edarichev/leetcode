; Proc2 . Описать процедуру PowerA234( A , B , C , D ), вычисляющую вторую, 
; третью и четвертую степень числа A и возвращающую эти степени соответственно 
; в переменных B , C и D ( A — входной, B , C , D — выходные параметры; 
; все параметры являются вещественными). С помощью этой процедуры
; найти вторую, третью и четвертую степень пяти данных чисел.
;
; Вывод:
; 1: ^2 = 1, ^3 = 1, ^4 = 1
; 2: ^2 = 4, ^3 = 8, ^4 = 16
; 3: ^2 = 9, ^3 = 27, ^4 = 81
; 4: ^2 = 16, ^3 = 64, ^4 = 256
; 5: ^2 = 25, ^3 = 125, ^4 = 625
extern  printf

%macro  print_xmm 0
        mov     rax, 4
        mov     rdi, strFormat
        call    printf
%endmacro

section .data
        N1              dq      1.0
        N2              dq      2.0
        N3              dq      3.0
        N4              dq      4.0
        N5              dq      5.0
        strFormat       db      "%g: ^2 = %g, ^3 = %g, ^4 = %g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [N1]
        call    PowerA234
        print_xmm
        movsd   xmm0, [N2]
        call    PowerA234
        print_xmm
        movsd   xmm0, [N3]
        call    PowerA234
        print_xmm
        movsd   xmm0, [N4]
        call    PowerA234
        print_xmm
        movsd   xmm0, [N5]
        call    PowerA234
        print_xmm

        leave
        ret

PowerA234:
        ; 2,3,4 степень
        ; Вход: xmm0 - число, double
        ; Выход: xmm1 - x^2, xmm2 - x^3, xmm3 - x^4
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm1, xmm0
        mulsd   xmm1, xmm0      ; ^2
        movsd   xmm2, xmm1      ; <- ^2
        mulsd   xmm2, xmm0      ; ^3
        movsd   xmm3, xmm2      ; <- ^3
        mulsd   xmm3, xmm0      ; ^4
        
        leave
        ret
