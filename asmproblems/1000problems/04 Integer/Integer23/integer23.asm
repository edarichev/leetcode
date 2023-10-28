; Integer23 . С начала суток прошло N секунд ( N — целое). 
; Найти количество полных минут, прошедших с начала последнего часа.
;
; Вывод:
; 6789 -> 53
extern  printf
section .data
        ; в сутках 86400 секунд
        ; в часе 3600 сек.
        N       equ     6789
        strFormat      db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; нужно 4-байтовое число в общем случае (для 86400, если понадобится)
        mov     eax, N
        cdq
        mov     ebx, 60         ; делим на 3600, нужны полные минуты вообще
        idiv    ebx             ; ->edx:eax, eax - минуты
        cdq
        mov     ebx, 60         ; теперь /60 -> часы в eax, минуты в edx
        idiv    ebx

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, N
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
