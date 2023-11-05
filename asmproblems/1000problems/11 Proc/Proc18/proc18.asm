; Proc18 . Описать функцию CircleS( R ) вещественного типа, находящую площадь
; круга радиуса R ( R — вещественное). С помощью этой функции найти
; площади трех кругов с данными радиусами. Площадь круга радиуса R 
; вычисляется по формуле S = π · R 2 . В качестве значения π использовать 3.14.
;
; Вывод:
; R=1 -> S=3.14
; R=4 -> S=50.24
; R=7 -> S=153.86


extern  printf
section .data
        R1              dq      1.0
        R2              dq      4.0
        R3              dq      7.0
        strFormat       db      "R=%g -> S=%g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; R1
        movsd   xmm0, [R1]
        call    CircleS
        movsd   xmm1, xmm0
        
        mov     rdi, strFormat
        mov     rax, 2
        movsd   xmm0, [R1]
        call    printf
        
        ; R2
        movsd   xmm0, [R2]
        call    CircleS
        movsd   xmm1, xmm0
        
        mov     rdi, strFormat
        mov     rax, 2
        movsd   xmm0, [R2]
        call    printf

        ; R3
        movsd   xmm0, [R3]
        call    CircleS
        movsd   xmm1, xmm0
        
        mov     rdi, strFormat
        mov     rax, 2
        movsd   xmm0, [R3]
        call    printf

        leave
        ret

CircleS:
        ; CircleS
        ; Вход: xmm0 - R
        ; Выход: xmm0: S
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        section .data
                PI              dq      3.14
        section .text
                push    rbp
                mov     rbp, rsp
                
                mulsd   xmm0, xmm0
                mulsd   xmm0, [PI]

                leave
                ret
