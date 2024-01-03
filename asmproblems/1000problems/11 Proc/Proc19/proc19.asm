; Proc19 . Описать функцию RingS( R 1 , R 2 ) вещественного типа, находящую площадь 
; кольца, заключенного между двумя окружностями с общим центром
; и радиусами R 1 и R 2 ( R 1 и R 2 — вещественные, R 1 > R 2 ). С ее помощью найти 
; площади трех колец, для которых даны внешние и внутренние радиусы.
; Воспользоваться формулой площади круга радиуса R : S = π · R^2 . В качестве
; значения π использовать 3.14.
;
; Вывод:
; S=47.1

extern  printf
section .data
        R1              dq      1.0
        R2              dq      4.0
        strFormat       db      "S=%g",10,0
section .bss
        S               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [R2]
        call    CircleS
        movsd   [S], xmm0
        
        movsd   xmm0, [R1]
        call    CircleS
        movsd   xmm1, [S]
        subsd   xmm1, xmm0
        movsd   [S], xmm1
        
        mov     rdi, strFormat
        movsd   xmm0, [S]
        mov     rax, 1
        call    printf
        leave
        ret

CircleS:
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
