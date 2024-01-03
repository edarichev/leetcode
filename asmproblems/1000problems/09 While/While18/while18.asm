; While18 . Дано целое число N (> 0). Используя операции деления нацело и взятия 
; остатка от деления, найти количество и сумму его цифр.
;
; Вывод:
; кол-во цифр = 5, сумма = 15

extern  printf
section .data
        N               equ     12345
        strFormat       db      "кол-во цифр = %d, сумма = %d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rax, N
        mov     rsi, 0          ; rsi=кол-во цифр
        xor     rcx, rcx        ; rcx=S==0
        mov     rbx, 10         ; делитель
loop_i:
        test    rax, rax
        jz      exit
        cdq
        div     rbx
        add     rcx, rdx
        inc     rsi
        jmp     loop_i
exit:
        mov     rax, 0
        mov     rdi, strFormat
        ; rsi == кол-во цифр
        mov     rdx, rcx        ; rdx == сумма
        call    printf
        leave
        ret
