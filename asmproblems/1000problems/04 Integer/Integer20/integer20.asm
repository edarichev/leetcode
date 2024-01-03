; Integer20 ° . С начала суток прошло N секунд ( N — целое). Найти количество
; полных часов, прошедших с начала суток.
;
; Вывод:
; 6789 -> 1 (это 113 минут, 1 полный час, почти 2)
extern  printf
section .data
        ; в сутках 86400 секунд
        N       equ     6789
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
        mov     ebx, 3600
        idiv    ebx
        movsx   rdx, eax         ; тут часы

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, N
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
