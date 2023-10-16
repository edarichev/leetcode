; If7 . Даны два числа. Вывести порядковый номер меньшего из них.
;
; Вывод:
; -20, -25 -> 1
extern  printf

section .data
        A               equ     -20
        B               equ     -25
        strFormat       db      "%d, %d -> %d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        xor     rcx, rcx        ; пусть порядковый в rcx и №==0
        mov     rax, A
        mov     rbx, B
        cmp     rax, rbx
        jle     done
        mov     rcx, 1
done:
        ; вывод: выбираем строку True/False по значению rax
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, A
        mov     rdx, B
        call    printf
        leave
        ret
