; For20 ° . Дано целое число N (> 0). Используя один цикл, найти сумму
; 1! + 2! + 3! + ... + N !
; (выражение N ! — N–факториал — обозначает произведение всех целых
; чисел от 1 до N : N ! = 1·2·...· N ). Чтобы избежать целочисленного 
; переполнения, проводить вычисления с помощью вещественных переменных и
; вывести результат как вещественное число.
;
; Вывод:
; Summ = 33 (при N=4: 1! + 2! + 3! + 4! = 1+2 +6 + 24=33)

extern  printf
section .data
        N               equ     4
        strFormat       db      "Summ = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rax, 1
        cvtsi2sd xmm0, rax      ; текущее значение факториала
        mov     rcx, 1
        mov     rbx, N
        pxor    xmm2, xmm2      ; Сумма факториалов
for_loop:
        cmp     rcx, rbx
        jg      done
        cvtsi2sd xmm1, rcx
        mulsd   xmm0, xmm1
        addsd   xmm2, xmm0
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
