; Integer13 . Дано трехзначное число. В нем зачеркнули первую слева цифру и
; приписали ее справа. Вывести полученное число.
;
; Вывод:
; 372 -> 723
extern  printf
section .data
        A       equ     372
        strFormat      db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        ; сотни
        mov     ax, A
        cwd                     ; ax->dx:ax
        mov     bx, 100
        idiv    bx
        movsx   rax, ax         ; частное - это сотни
        mov     r8, rax         ; сотни
        ; остаток в dx
        movsx   rdx, dx
        imul    rdx, 10
        add     rdx, r8

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, A
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
