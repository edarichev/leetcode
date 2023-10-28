; Integer17 . Дано целое число, большее 999. Используя одну операцию деления
; нацело и одну операцию взятия остатка от деления, найти цифру, соответствующую 
; разряду сотен в записи этого числа.
;
; Вывод:
; 1234 -> 2
extern  printf
section .data
        A       equ     1234
        strFormat      db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        ; уберём десятки
        mov     ax, A
        cwd
        mov     bx, 100
        idiv    bx
        ; теперь делим на 10, чтобы достать сотни
        cwd
        mov     bx, 10
        idiv    bx
        movsx   rdx, dx         ; тут десятки

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, A
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
