; If15 . Даны три числа. Найти сумму двух наибольших из них.
;
; Вывод:
; 15, 20, 11 -> 35
extern  printf

section .data
        A               dq      15.0
        B               dq      20.0
        C               dq      1.0
        strFormat       db      "%g, %g, %g -> %g",10,0
section .bss
        Sum             resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        ; для разнообразия использую вещественные
        ; подобие сортировки:
        ; для "массива" выберу регистры xmm5, xmm6, xmm7; нужны будут xmm6 + xmm7 (max)
        ; заносим изначальный набор:
        movsd   xmm5, [A]
        movsd   xmm6, [B]
        movsd   xmm7, [C]
        xor     rcx, rcx
check5_6:
        movsd   xmm0, xmm5      ; копия, т.к. при сравнении левый затирается
        cmplepd xmm0, xmm6      ; 11111..11111 или 0000....0000
        movq    rax, xmm0
        test    rax, rax
        jnz     check6_7        ; [5] <= [6]
        pxor    xmm5, xmm6
        pxor    xmm6, xmm5
        pxor    xmm5, xmm6
        test    rcx, rcx
        jnz     done
check6_7:
        movsd   xmm0, xmm6
        cmppd   xmm0, xmm7, 02h ; == cmplepd
        movq    rax, xmm0
        test    rax, rax
        jnz     check5_6
        pxor    xmm6, xmm7
        pxor    xmm7, xmm6
        pxor    xmm6, xmm7
        mov     rcx, 1          ; признак последнего прохода 
        jmp     check5_6        ; код сравнения [5] и [6] аналогичен, прыгнем туда, чтобы не дублировать
done:
        movsd   xmm0, xmm6
        addsd   xmm0, xmm7
        movsd   [Sum], xmm0
        ; вывод: выбираем строку True/False по значению rax
        mov     rax, 4          ; кол-во вещественных
        mov     rdi, strFormat
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        movsd   xmm2, [C]
        movsd   xmm3, [Sum]
        call    printf
        leave
        ret
