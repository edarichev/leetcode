; If8 ° . Даны два числа. Вывести вначале большее, а затем меньшее из них.
;
; Вывод:
; 20, 25 -> 25, 20
extern  printf

section .data
        A               equ     20
        B               equ     25
        strFormat       db      "%d, %d -> %d, %d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        ; нужно 2 регистра: rcx, r8 чтобы сразу вывести
        mov     rcx, A
        mov     r8,  B
        cmp     rcx, r8
        jge     done
        xchg    r8, rcx         ; если rcx < r8, обменяем
done:
        ; вывод: выбираем строку True/False по значению rax
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, A
        mov     rdx, B
        call    printf
        leave
        ret
