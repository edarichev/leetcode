; If14 . Даны три числа. Вывести вначале наименьшее, а затем наибольшее из данных чисел.
;
; Вывод:
; 15, 20, 11 -> 11, 20
extern  printf

section .data
        A               dq      15.0
        B               dq      20.0
        C               dq      1.0
        strFormat       db      "%g, %g, %g -> %g, %g",10,0
section .bss
        NMin            resq    1
        NMax            resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        ; для разнообразия использую вещественные
        ; подобие сортировки:
        ; для "массива" выберу регистры xmm5, xmm6, xmm7; нужны будут xmm5 (min), xmm7 (max)
        ; заносим изначальный набор:
        movsd   xmm5, [A]
        movsd   xmm6, [B]
        movsd   xmm7, [C]
        ; порядок сравнения xmm: 5,6; 6,7; 5,6
        movsd   xmm0, xmm5      ; нужно скопировать, т.к. сравнение затирает первый регистр из двух
        cmplepd xmm0, xmm6
        movq    rax, xmm0
        test    rax, rax
        jnz     check6_7        ; [5] <= [6], ok
        pxor    xmm5, xmm6      ; меняем [5] и [6]
        pxor    xmm6, xmm5
        pxor    xmm5, xmm6
check6_7:
        movsd   xmm0, xmm6
        cmplepd xmm0, xmm7
        movq    rax, xmm0
        test    rax, rax
        jnz     check5_6
        pxor    xmm6, xmm7
        pxor    xmm7, xmm6
        pxor    xmm6, xmm7
check5_6:                       ; аналогичный блок
        movsd   xmm0, xmm5      ; нужно скопировать, т.к. сравнение затирает первый регистр из двух
        cmplepd xmm0, xmm6
        movq    rax, xmm0
        test    rax, rax
        jnz     check6_7        ; [5] <= [6], ok
        pxor    xmm5, xmm6      ; меняем [5] и [6]
        pxor    xmm6, xmm5
        pxor    xmm5, xmm6
        
done:
        movsd   [NMin], xmm5
        movsd   [NMax], xmm7
        ; вывод:
        mov     rax, 5          ; кол-во вещественных
        mov     rdi, strFormat
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        movsd   xmm2, [C]
        movsd   xmm3, [NMin]
        movsd   xmm4, [NMax]
        call    printf
        leave
        ret
