; If13 . Даны три числа. Найти среднее из них (то есть число, расположенное между наименьшим и наибольшим).
;
; Вывод:
; 15, 20, 11 -> 20
extern  printf

section .data
        A               dq      15.0
        B               dq      20.0
        C               dq      1.0
        strFormat       db      "%g, %g, %g -> %g",10,0
section .bss
        N               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        ; для разнообразия использую вещественные
        ; подобие сортировки:
        ; для "массива" выберу регистры xmm5, xmm6, xmm7, из них xmm6 после манипуляций будет средним
        ; заносим изначальный набор:
        movsd   xmm5, [A]
        movsd   xmm6, [B]
        movsd   xmm7, [C]
        ; порядок сравнения xmm: 5,6; 6,7; 5,6
        movsd   xmm0, xmm5
        cmplepd xmm0, xmm6
        movq    rax, xmm0
        test    rax, rax
        jnz     cmp6_7          ; [5] <= [6], ok
        pxor    xmm5, xmm6      ; [5] > [6]
        pxor    xmm6, xmm5      ; меняем xmm5 и xmm6
        pxor    xmm5, xmm6
cmp6_7:
        movsd   xmm0, xmm6
        cmplepd xmm0, xmm7
        movq    rax, xmm0
        test    rax, rax
        jnz     cmp5_6
        pxor    xmm6, xmm7
        pxor    xmm7, xmm6
        pxor    xmm6, xmm7
cmp5_6:                         ; повторяем сравнение 5 и 6
        movsd   xmm0, xmm5
        cmplepd xmm0, xmm6
        movq    rax, xmm0
        test    rax, rax
        jnz     done
        movsd   xmm6, xmm5      ; важно только в xmm6
done:
        movsd   [N], xmm6
        ; вывод: выбираем строку True/False по значению rax
        mov     rax, 4          ; кол-во вещественных
        mov     rdi, strFormat
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        movsd   xmm2, [C]
        movsd   xmm3, [N]
        call    printf
        leave
        ret
