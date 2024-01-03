; Begin23 . Даны переменные A, B, C. Изменить их значения, переместив 
; содержимое A в B, B — в C, C — в A, и вывести новые значения переменных A, B, C.
; Вывод:
; (-9, 4, 12.3) -> (12.3, -9, 4)
extern  printf

section .data
        A       dq      -9.0
        B       dq      4.0
        C       dq      12.3
        strFormat       db      "(%g, %g, %g) -> (%g, %g, %g)",10,0
section .bss
        a       resq    1
        b       resq    1
        c       resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; сохраним оригинал для вывода
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        movsd   xmm2, [C]
        ; 3,4,5 переставим
        movsd   xmm3, xmm2
        movsd   xmm4, xmm0
        movsd   xmm5, xmm1
        movsd   [a], xmm3
        movsd   [b], xmm4
        movsd   [c], xmm5
       
        ; выводим
        mov     rax, 6          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
