; Proc28 . Описать функцию IsPrime( N ) логического типа, возвращающую True,
; если целый параметр N (> 1) является простым числом, и False в противном 
; случае (число, большее 1, называется простым , если оно не имеет 
; положительных делителей, кроме 1 и самого себя). Дан набор из 10 целых
; чисел, больших 1. С помощью функции IsPrime найти количество простых
; чисел в данном наборе.
;
; Вывод:
; 4     (1,3,5,17)

extern  printf

section .data
        series1         dq      1,25,3,4,5,6,25,125,25,17,10
        End             dq      $
        N               equ     2
        strFormat       db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rbx, 0          ; сумма здесь: rbx сохраняется между вызовами
        mov     rsi, series1
loop_i:
        cmp     rsi, End
        jge     break_i
        push    rsi
        sub     rsp, 8
        mov     rdi, [rsi]
        call    IsPrime
        test    rax, rax
        jz      next
        inc     rbx
next:
        add     rsp, 8
        pop     rsi
        add     rsi, 8
        jmp     loop_i
break_i:
        xor     rax, rax
        mov     rdi, strFormat
        mov     rsi, rbx
        call    printf
        leave
        ret

IsPrime:
        ; Вход: 
        ;       rdi - K
        ; Выход: rax: 1, 0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, rdi
        shr     rcx, 1          ; = /2
        cmp     rcx, 1
        je      .is_prime       ; 1, 2, 3
.loop_prime:
        cmp     rcx, 1
        jle     .is_prime
        mov     rax, rdi
        cdq
        idiv    rcx
        test    rdx, rdx
        jz      .not_prime
        dec     rcx
        jmp     .loop_prime
.is_prime:
        mov     rax, 1
        jmp     .exit
.not_prime:
        xor     rax, rax
.exit:
        
        leave
        ret
