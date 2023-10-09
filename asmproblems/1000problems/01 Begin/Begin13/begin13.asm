; Begin13. Даны два круга с общим центром и радиусами R 1 и R 2 ( R 1 > R 2 ). Найти
; площади этих кругов S 1 и S 2 , а также площадь S 3 кольца, внешний радиус
; которого равен R 1 , а внутренний радиус равен R 2 :
; S 1 = π ·( R 1 )^2 ,
; S 2 = π ·( R 2 )^2 ,
; S 3 = S 1 – S 2 .
; В качестве значения π использовать 3.14.
;
; Вывод:
; R1=9, R2=4, S1=254.34, S2=50.24, S3=204.1
extern  printf
section .data
        PI      dq      3.14
        R1      dq      9.0
        R2      dq      4.0
        strFormat       db      "R1=%g, R2=%g, S1=%g, S2=%g, S3=%g",10,0
section .bss
        S1      resq    1
        S2      resq    1
        S3      resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; S1
        movsd   xmm0, [PI]
        movsd   xmm3, [R1]
        mulsd   xmm3, xmm3      ; R1^2
        mulsd   xmm0, xmm3      ; S1 -> xmm0
        movsd   [S1], xmm0
        
        ; S2
        movsd   xmm1, [PI]
        movsd   xmm3, [R2]
        mulsd   xmm3, xmm3      ; R2^2
        mulsd   xmm1, xmm3      ; S2 -> xmm1
        movsd   [S2], xmm1

        ; S3 = S1-S2
        movsd   xmm2, xmm0
        subsd   xmm2, xmm1
        movsd   [S3], xmm2
        
        ; выводим
        movsd   xmm0, [R1]
        movsd   xmm1, [R2]
        movsd   xmm2, [S1]
        movsd   xmm3, [S2]
        movsd   xmm4, [S3]
        mov     rax, 5          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
