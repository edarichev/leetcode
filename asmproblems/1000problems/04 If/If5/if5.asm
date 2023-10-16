; If5 . Даны три целых числа. Найти количество положительных и количество отрицательных чисел в исходном наборе.
;
; Вывод:
; -20, 0, 7
extern  printf

section .data
        A               equ     -20
        B               equ     0
        C               equ     7
        strFormat       db      "%d, %d, %d -> %d (<0), %d (>0)",10,0
section .bss
        NP              resq    1       ; > 0
        NN              resq    1       ; < 0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        xor     rcx, rcx        ; счётчик > 0
        xor     rdx, rdx        ; счётчик < 0
        
        mov     rax, A
        call    check
        mov     rax, B
        call    check
        mov     rax, C
        call    check

        mov     [NP], rcx
        mov     [NN], rdx
        ; вывод
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, A
        mov     rdx, B
        mov     rcx, C
        mov     r8, [NP]
        mov     r9, [NN]
        call    printf
        leave
        ret

check:
        ; проверяет rax <0,>0,==0
        ; вход: rax - число
        ; выход:
        ; увеличивает rcx, если >0
        ; увеличивает rdx, если <0
        push    rbp
        mov     rbp, rsp
        
        cmp     rax, 0
        jg      .positive
        jl      .negative
        leave                   ; == 0, не считать
        ret
.positive:
        inc     rcx
        leave
        ret
.negative:
        inc     rdx
        leave
        ret
