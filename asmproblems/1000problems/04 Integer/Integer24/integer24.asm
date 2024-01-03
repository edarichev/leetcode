; Integer24 . Дни недели пронумерованы следующим образом: 0 — воскресенье,
; 1 — понедельник, 2 — вторник, ..., 6 — суббота. Дано целое число K , 
; лежащее в диапазоне 1–365. Определить номер дня недели для K -го дня года,
; если известно, что в этом году 1 января было понедельником.
;
; Вывод:
; 364 -> 0
; 2018, например. K=364 - воскресенье=0
extern  printf
section .data
        K       equ     364
        strFormat      db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; поскольку год начинается с понедельника,
        ; здесь достаточно определить, сколько полных недель укладывается
        ; и сколько дней в остатке от деления на 7
        ; нужно 2-байтовое число(1-366)
        mov     ax, K
        cwd
        mov     bx, 7           ; 7 дней в неделе
        idiv    bx              ; dx - остаток, сколько прошло дней в новой неделе
        movsx   rdx, dx

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, K
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
