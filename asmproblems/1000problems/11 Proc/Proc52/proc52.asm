; Proc52 . Описать функцию IsLeapYear( Y ) логического типа, которая возвращает
; True, если год Y (целое положительное число) является високосным, и
; False в противном случае. Вывести значение функции IsLeapYear для пяти
; данных значений параметра Y . Високосным считается год, делящийся на 4,
; за исключением тех годов, которые делятся на 100 и не делятся на 400.
;
; Вывод:
; 2000: False

extern  printf

section .data
        Year            equ     2000
        strFormat       db      "%d: %s",10,0
        strTrue         db      "True",0
        strFalse        db      "False",0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rdi, Year
        call    IsLeapYear
        
        mov     rdi, strFormat
        mov     rsi, Year
        test    rax, rax
        jz      set_false
        mov     rdx, strTrue
        jmp     write
set_false:
        mov     rdx, strFalse
write:
        xor     rax, rax
        call    printf
exit:
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
