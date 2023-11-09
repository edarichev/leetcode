; Proc36 . Описать функцию Fib( N ) целого типа, вычисляющую N -й элемент 
; последовательности чисел Фибоначчи F K , которая описывается следующими формулами:
; F 1 = 1,
; F 2 = 1,
; F K = F K–2 + F K–1 , K = 3, 4, ... .
; Используя функцию Fib, найти пять чисел Фибоначчи с данными номерами N 1 , N 2 , ..., N 5 .
;
; Вывод:
; F(1) = 1
; F(2) = 1
; F(3) = 2
; F(4) = 3
; F(5) = 5

extern  printf

section .data
        series1         dq      1, 2, 3, 4, 5
        End             dq      $
        N               equ     5
        strFormat       db      "F(%d) = %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, series1
        and     rsp, 0xfffffffffffffff0
loop_i:
        cmp     rsi, End
        jge     break_i
        
        push    rsi
        sub     rsp, 8
        
        mov     rdi, qword [rsi]
        call    Fact2
        
        mov     rdi, strFormat
        mov     rdx, rax
        mov     rsi, qword [rsi]
        call    printf
        
        add     rsp, 8
        pop     rsi
        add     rsi, 8
        jmp     loop_i
break_i:
        leave
        ret

Fact2:
        ; Вход: 
        ;       rdi - N
        ; Выход: rax
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        xor     rax, rax
        cmp     rdi, 0          ; № <= 0 нельзя, будем считать с 1
        jle     .exit
        
        mov     rax, 1          ; первые два: первое, K-1
        mov     rdx, 1          ; второе, K
        cmp     rdi, 2
        jle     .exit           ; F(1) и F(2) == 1
        mov     rcx, 2
.loop_fibo:
        inc     rcx
        add     rax, rdx        ; следующий == сумма двух предыдущих, сложим и пометсим в rax
        xchg    rax, rdx        ; обменяем: теперь в rax будет тот, что только что был последним
        cmp     rcx, rdi
        jl      .loop_fibo
.exit:
        mov     rax, rdx
        leave
        ret
