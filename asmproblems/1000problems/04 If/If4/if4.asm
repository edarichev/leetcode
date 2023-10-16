; If4 ° . Даны три целых числа. Найти количество положительных чисел в исходном наборе.
;
; Вывод:
; -20, 4, 7 -> 2
extern  printf
section .data
        A               equ     -20
        B               equ     4
        C               equ     7
        strFormat       db      "%d, %d, %d -> %d",10,0
section .bss
        N               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        xor     rcx, rcx        ; как счётчик
        mov     rax, A
        cmp     rax, 0
        jle     checkB
        inc     rcx
checkB:
        mov     rax, B
        cmp     rax, 0
        jle     checkC
        inc     rcx
checkC:
        mov     rax, C
        cmp     rax, 0
        jle     done
        inc     rcx
done:
        mov     [N], rcx
        ; вывод: выбираем строку True/False по значению rax
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, A
        mov     rdx, B
        mov     rcx, C
        mov     r8, [N]
        call    printf
        leave
        ret

