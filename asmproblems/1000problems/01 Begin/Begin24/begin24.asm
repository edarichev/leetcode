;Begin24 . Даны переменные A, B, C. Изменить их значения, переместив содержимое 
; A в C, C — в B, B — в A, и вывести новые значения переменных A, B, C.
; Вывод:
; (-9, 4, 12.3) -> (4, 12.3, -9)
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
        movsd   xmm3, xmm1      ; a
        movsd   xmm4, xmm2      ; b
        movsd   xmm5, xmm0      ; c
        movsd   [a], xmm3
        movsd   [b], xmm4
        movsd   [c], xmm5
       
        ; выводим
        mov     rax, 6          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
