; For15 ° . Дано вещественное число A и целое число N (> 0). Найти A в степени N :
; A^N = A · A · ... · A
; (числа A перемножаются N раз).
;
; Вывод:
; 2 ^ 10 = 1024

extern  printf
section .data
        A               dq      2.0
        N               equ     10
        strFormat       db      "%g ^ %d = %g",10,0
        NL              db      10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, 1          ; счётчик
        mov     rbx, N
        cvtsi2sd xmm1, rcx      ; <- 1, начальное произведение
        movsd   xmm0, [A]
for_loop:
        cmp     rcx, rbx
        jg      done
        mulsd   xmm1, xmm0
        inc     rcx
        jmp     for_loop
done:
        mov     rax, 2          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, N
        call    printf
        leave
        ret
