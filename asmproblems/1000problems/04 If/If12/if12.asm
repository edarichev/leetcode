; If12 ° . Даны три числа. Найти наименьшее из них.
;
; Вывод:
; 25, 20, 11 -> 11
extern  printf

section .data
        A               dq      15.0
        B               dq      20.0
        C               dq      11.0
        strFormat       db      "%g, %g, %g -> %g",10,0
section .bss
        N               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        ; для разнообразия использую вещественные
        movsd   xmm0, [A]
        movsd   xmm2, xmm0
        movsd   xmm1, [B]
        cmplepd xmm0, xmm1
        movmskpd rax, xmm0
        test    rax, 1          ; если условие верно, то в нижнем бите д.б. 1
        jz      minFromXmm1     ; неверно, перенесём в xmm0 из xmm1
        movsd   xmm0, xmm2      ; верно, оставим A в xmm0, он минимальный
        jmp     checkB
minFromXmm1:
        movsd   xmm0, xmm1
checkB:
        ; здесь минимум в xmm0
        movsd   xmm2, xmm0      ; сохраним, т.к. при сравнении он затрётся
        movsd   xmm1, [C]
        cmplepd xmm0, xmm1
        movmskpd rax, xmm0
        test    rax, 1
        jz      minFromXmm1_1   ; неверно, перенесём в xmm0 из xmm1
        movsd   xmm0, xmm2      ; верно, вернём минимум в xmm0, т.к. он затёрт
        jmp     done
minFromXmm1_1:
        movsd   xmm0, xmm1
done:
        movsd   [N], xmm0
        ; вывод
        mov     rax, 4          ; кол-во вещественных
        mov     rdi, strFormat
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        movsd   xmm2, [C]
        movsd   xmm3, [N]
        call    printf
        leave
        ret
