; Proc54 . Используя функцию MonthDays из задания Proc53, описать процедуру
; PrevDate( D , M , Y ), которая по информации о правильной дате, 
; включающей день D , номер месяца M и год Y , определяет предыдущую дату 
; (параметры целого типа D , M , Y являются одновременно входными и выходными). 
; Применить процедуру PrevDate к трем исходным датам и вывести полученные значения предыдущих дат.
;
; Вывод:
; 2000.02.01
; 2000.01.31
;
; 2000.02.12
; 2000.02.11
; 
; 2000.01.01
; 1999.12.31

extern  printf

section .data
        Year            dq      2000
        Month           dq      1
        Day             dq      1
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
        call    PrevDate
        
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
PrevDate:
        ; Вход: rdi - год, in/out, адрес
        ;       rsi - месяц, in/out, адрес
        ;       rdx - день, in/out, адрес
        push    rbp
        mov     rbp, rsp
        
        cmp     qword [rdx], 1
        jne     .simple
        ; иначе надо уменьшить месяц и поставить на последнее число месяца
        mov     rax, qword [rsi]
        dec     rax
        mov     qword [rsi], rax
        cmp     rax, 0
        jne     .this_year
        ; иначе переходим в предыдущий год, просто 31.12.(год-1)
        mov     qword [rsi], 12
        mov     qword [rdx], 31
        mov     rax, qword [rdi]
        dec     rax
        mov     qword [rdi], rax
        jmp     .exit
.this_year:
        ; в пределах года, ищем предыдущий месяц и число дней в нём
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
        mov     qword [rdx], rax
        jmp     .exit
.simple:
        ; простой вариант, в пределах месяца и до 1 числа - просто уменьшим на 1
        mov     rax, [rdx]
        dec     rax
        mov     [rdx], rax
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
