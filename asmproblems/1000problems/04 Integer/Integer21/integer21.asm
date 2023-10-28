; Integer21 . С начала суток прошло N секунд ( N — целое). Найти количество секунд, прошедших с начала последней минуты.
;
; Вывод:
; 6789 -> 9 (это 113 минут, 9 секунд)
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
        mov     ebx, 60         ; делим на 60, нужны минуты
        idiv    ebx             ; ->edx:eax
        movsx   rdx, edx        ; остаток - это секунды

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, N
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
