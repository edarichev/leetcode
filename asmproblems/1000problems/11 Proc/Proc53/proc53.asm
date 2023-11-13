; Proc53 . Используя функцию IsLeapYear из задания Proc52, описать функцию
; MonthDays( M , Y ) целого типа, которая возвращает количество дней для
; M -го месяца года Y (1 ≤ M ≤ 12, Y > 0 — целые числа). Вывести значение
; функции MonthDays для данного года Y и месяцев M 1 , M 2 , M 3 .
;
; Вывод:
; 2004, 2: 29
; 2000, 2: 31

extern  printf

section .data
        Year            equ     2000
        Month           equ     2
        strFormat       db      "%d, %d: %d",10,0
        Days365         dq      31,28,31, 30,31,30, 31,31,30, 31,30,31
        Days366         dq      31,29,31, 30,31,30, 31,31,30, 31,30,31
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rdi, Year
        mov     rsi, Month
        call    MonthDays
        
        mov     rdi, strFormat
        mov     rsi, Year
        mov     rdx, Month
        mov     rcx, rax
        xor     rax, rax
        call    printf
exit:
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MonthDays:
        ; Вход: rdi - год
        ;       rsi - месяц
        ; Выход: rax - число дней
        push    rbp
        mov     rbp, rsp
        
        push    rdi
        push    rsi
        call    IsLeapYear
        
        pop     rsi
        pop     rdi
        
        test    rax, rax
        jnz     .set_leap
        mov     rdx, Days365
        jmp     .check
.set_leap:
        mov     rdx, Days366
.check:
        dec     rsi     ; к 0
        mov     rax, qword [rdx + rsi * 8]
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IsLeapYear:
        ; Вход: rdi - год
        ; Выход: rax - 1/0
        push    rbp
        mov     rbp, rsp

        mov     rax, rdi
        mov     rcx, 400
        cdq
        idiv    rcx
        test    rdx, rdx
        jz      .false          ; на 400 делится, а не должно
        mov     rax, 1
        jmp     .exit

        mov     rax, rdi
        mov     rcx, 4
        cdq
        idiv    rcx
        test    rdx, rdx
        jnz     .false          ; на 4 не делится
        ; на 100 проверять не нужно, оно уже делится на 4, а 400 проверили выше
.false:
        xor     rax, rax
.exit:
        leave
        ret
