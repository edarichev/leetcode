; While19 . Дано целое число N (> 0). Используя операции деления нацело и взятия 
; остатка от деления, найти число, полученное при прочтении числа N справа налево.
;
; Вывод:
; N = 12345, M = 54321

extern  printf
section .data
        N               equ     12345
        strFormat       db      "N = %d, M = %d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rax, N
        mov     rbx, 10         ; делитель
        xor     rcx, rcx
loop_i:
        test    rax, rax
        jz      exit
        cdq
        div     rbx
        imul    rcx, 10
        add     rcx, rdx
        jmp     loop_i
exit:
        mov     rax, 0
        mov     rdi, strFormat
        mov     rsi, N
        mov     rdx, rcx
        call    printf
        leave
        ret
