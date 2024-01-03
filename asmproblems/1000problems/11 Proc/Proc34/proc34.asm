; Proc34 . Описать функцию Fact( N ) вещественного типа, вычисляющую значение 
; факториала N ! = 1·2·...· N ( N > 0 — параметр целого типа; вещественное
; возвращаемое значение используется для того, чтобы избежать 
; целочисленного переполнения при больших значениях N ). С помощью этой
; функции найти факториалы пяти данных целых чисел.
;
; Вывод:
; 5! = 120
; 10! = 3.6288e+06
; 15! = 1.30767e+12
; 20! = 2.4329e+18
; 25! = 1.55112e+25

extern  printf

section .data
        series1         dq      5, 10, 15, 20, 25
        End             dq      $
        N               equ     5
        strFormat       db      "%d! = %g",10,0
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
        call    Fact
        
        mov     rdi, strFormat
        ; xmm0 - в результате
        mov     rsi, qword [rsi]
        call    printf
        
        add     rsp, 8
        pop     rsi
        add     rsi, 8
        jmp     loop_i
break_i:
        leave
        ret

Fact:
        ; Вход: 
        ;       rdi - N
        ; Выход: xmm0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        pxor    xmm0, xmm0      ; 0 - ошибка
        cmp     rdi, 0
        jl      .exit
        mov     rax, 1
        cvtsi2sd xmm0, rax      ; 1 - нач. произведение
.loop_fact:
        test    rdi, rdi
        jz      .exit
        cvtsi2sd xmm1, rdi
        mulsd   xmm0, xmm1
        dec     rdi
        jmp     .loop_fact
.exit:
        
        leave
        ret
