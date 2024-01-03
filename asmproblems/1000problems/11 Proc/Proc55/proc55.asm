; Proc55 . Используя функцию MonthDays из задания Proc53, описать процедуру
; NextDate( D , M , Y ), которая по информации о правильной дате, включающей 
; день D , номер месяца M и год Y , определяет следующую дату 
; (параметры целого типа D , M , Y являются одновременно входными и выходными). 
; Применить процедуру NextDate к трем исходным датам и вывести полученные значения следующих дат.
;
; Вывод:
; 2000.01.01
; 2000.01.02
;
; 2000.01.31
; 2000.02.01
; 
; 2000.12.31
; 2001.01.01

extern  printf

section .data
        Year            dq      2000
        Month           dq      12
        Day             dq      31
        strFormat       db      "%04d.%02d.%02d",10,0
        Days365         dq      31,28,31, 30,31,30, 31,31,30, 31,30,31
        Days366         dq      31,29,31, 30,31,30, 31,31,30, 31,30,31
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; исходная
        mov     rdi, strFormat
        mov     rsi, [Year]
        mov     rdx, [Month]
        mov     rcx, [Day]
        xor     rax, rax
        call    printf
        ; найти предыдущую
        mov     rdi, Year
        mov     rsi, Month
        mov     rdx, Day
        call    NextDate
        
        mov     rdi, strFormat
        mov     rsi, [Year]
        mov     rdx, [Month]
        mov     rcx, [Day]
        xor     rax, rax
        call    printf
exit:
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NextDate:
        ; Вход: rdi - год, in/out, адрес
        ;       rsi - месяц, in/out, адрес
        ;       rdx - день, in/out, адрес
        push    rbp
        mov     rbp, rsp
        
        push    rdi
        push    rsi
        push    rdx
        sub     rsp, 8
        mov     rdi, qword [rdi]
        mov     rsi, qword [rsi]
        call    MonthDays
        add     rsp, 8
        pop     rdx
        pop     rsi
        pop     rdi
        cmp     [rdx], rax
        jl      .this_month
        ; в следующий месяц
        mov     qword [rdx], 1          ; 1-е число
        mov     rax, qword [rsi]
        inc     rax
        cmp     rax, 12
        jg      .next_year
        ; в пределах года
        mov     qword [rsi], rax        ; мы его только что увеличили, и всё нормально, число тоже выставили
        jmp     .exit                   ; а год тот же
.next_year:
        ; на 1.янв.(год+1)
        mov     rax, qword [rdi]
        inc     rax
        mov     qword [rdi], rax
        mov     qword [rsi], 1
        mov     qword [rdx], 1
        jmp     .exit
.this_month:
        mov     rax, qword [rdx]
        inc     rax
        mov     qword [rdx], rax
        jmp     .exit
.exit:
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
