; If6 ° . Даны два числа. Вывести большее из них.
;
; Вывод:
; -20, 0 -> 0
extern  printf

section .data
        A               equ     -20
        B               equ     0
        strFormat       db      "%d, %d -> %d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rcx, A          ; сразу rcx для вывода
        mov     rbx, B
        cmp     rcx, rbx
        jge     done
        mov     rcx, rbx
done:
        ; вывод: выбираем строку True/False по значению rax
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, A
        mov     rdx, B
        call    printf
        leave
        ret
