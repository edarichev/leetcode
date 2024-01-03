; Найти решение системы линейных уравнений вида
; A 1 · x + B 1 · y = C 1 ,
; A 2 · x + B 2 · y = C 2 ,
; заданной своими коэффициентами A 1 , B 1 , C 1 , A 2 , B 2 , C 2 , если известно, что
; данная система имеет единственное решение. Воспользоваться формулами
; x = ( C 1 · B 2 – C 2 · B 1 )/ D ,
; y = ( A 1 · C 2 – A 2 · C 1 )/ D ,
; где D = A 1 · B 2 – A 2 · B 1 .
; Пусть:
; 3x-y=2
; 3x-2y=9
; случай с одним решением
; Вывод:
; x = -1.66667, y = -7
extern  printf
section .data
        A1      dq      3.0
        B1      dq      -1.0
        C1      dq      2.0
        A2      dq      3.0
        B2      dq      -2.0
        C2      dq      9.0
        strFormat       db      "x = %g, y = %g",10,0
section .bss
        x       resq    1
        y       resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; D
        movsd   xmm7, [A1]
        mulsd   xmm7, [B2]
        movsd   xmm6, [A2]
        mulsd   xmm6, [B1]
        subsd   xmm7, xmm6      ; D->xmm7
        
        ; x = ( C 1 · B 2 – C 2 · B 1 )/ D ,
        movsd   xmm2, [C1]
        mulsd   xmm2, [B2]
        movsd   xmm3, [C2]
        mulsd   xmm3, [B1]
        subsd   xmm2, xmm3
        divsd   xmm2, xmm7
        movsd   [x], xmm2
        movsd   xmm0, xmm2
        ; y = ( A 1 · C 2 – A 2 · C 1 )/ D ,
        movsd   xmm2, [A1]
        mulsd   xmm2, [C2]
        movsd   xmm3, [A2]
        mulsd   xmm3, [C1]
        subsd   xmm2, xmm3
        divsd   xmm2, xmm7
        movsd   [y], xmm2
        movsd   xmm1, xmm2

        mov     rax, 2          ; кол-во вещественных
        mov     rdi, strFormat
        ; xmm0,1 уже заданы
        call    printf
        leave
        ret
