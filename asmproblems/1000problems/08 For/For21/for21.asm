; For21 . Дано целое число N (> 0). Используя один цикл, найти сумму
; 1 + 1/(1!) + 1/(2!) + 1/(3!) + ... + 1/( N !)
; (выражение N ! — N–факториал — обозначает произведение всех целых
; чисел от 1 до N : N ! = 1·2·...· N ). Полученное число является приближенным значением константы e = exp(1).
;
; Вывод:
; e = 2.71828

extern  printf
section .data
        N               equ     10
        strFormat       db      "e = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rax, 1
        cvtsi2sd xmm0, rax      ; текущее значение факториала
        movsd   xmm3, xmm0      ; 1.0, ещё понадобится
        mov     rcx, 1
        mov     rbx, N
        movsd   xmm2, xmm0      ; Сумма факториалов, тут 1, т.к. в цикле начнём с X(==1)^1
for_loop:
        cmp     rcx, rbx
        jg      done
        cvtsi2sd xmm1, rcx
        mulsd   xmm0, xmm1      ; i!
        movsd   xmm4, xmm3      ; <- 1.0
        divsd   xmm4, xmm0      ; 1.0/i!
        addsd   xmm2, xmm4
        inc     rcx
        jmp     for_loop
done:
        mov     rax, 1
        mov     rdi, strFormat
        mov     rsi, N
        movsd   xmm0, xmm2
        call    printf
        leave
        ret
