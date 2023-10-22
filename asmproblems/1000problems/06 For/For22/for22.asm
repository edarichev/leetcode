; For22 . Дано вещественное число X и целое число N (> 0). Найти значение выражения
; 1 + X + X^2 /(2!) + ... + X^N /( N !)
; ( N ! = 1·2·...· N ). Полученное число является приближенным значением
; функции exp в точке X .
;
; Вывод:
; exp(1) = 2.71828
; exp(3.2) = 24.5325     (N=60)
extern  printf
section .data
        X               dq      3.2
        N               equ     60
        strFormat       db      "exp(%g) = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rax, 1
        cvtsi2sd xmm0, rax      ; текущее значение факториала
        movsd   xmm3, [X]       ; const, ==X
        movsd   xmm4, xmm0      ; X^i, начальное произведение==1
        mov     rcx, 1
        mov     rbx, N
        movsd   xmm2, xmm0      ; Сумма факториалов, тут 1, т.к. в цикле начнём с X(==1)^1
for_loop:
        cmp     rcx, rbx
        jg      done
        cvtsi2sd xmm1, rcx
        mulsd   xmm0, xmm1      ; i!
        mulsd   xmm4, xmm3      ; <- ...*X
        movsd   xmm5, xmm4      ; копируем, чтобы xmm4 не затёрлось
        divsd   xmm5, xmm0      ; X^i/i!
        addsd   xmm2, xmm5
        inc     rcx
        jmp     for_loop
done:
        mov     rax, 2
        mov     rdi, strFormat
        movsd   xmm0, [X]
        movsd   xmm1, xmm2
        call    printf
        leave
        ret
