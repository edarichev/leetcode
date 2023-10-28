; Integer18 . Дано целое число, большее 999. Используя одну операцию деления
; нацело и одну операцию взятия остатка от деления, найти цифру, соответствующую 
; разряду тысяч в записи этого числа.
;
; Вывод:
; 678945 -> 8
extern  printf
section .data
        N       equ     678945
        strFormat      db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; нужно 4-байтовое число
        mov     eax, N
        cdq
        mov     ebx, 1000
        idiv    ebx
        ; ещё раз поделить, теперь на 10 и взять остаток
        cdq
        mov     ebx, 10
        idiv    ebx
        movsx   rdx, edx

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, N
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
