; Array29. Дан массив A размера N. Найти максимальный элемент из его элементов с нечетными номерами: A 1 , A 3 , A 5 , ... .
;
; Вывод:
; -3      (arr)
; 9      (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      -3, 2, -5, 1, -20, 4, -99, 160, -321, 20
        arr1            dq      1,-2,3,-4,5,6,7,8,9,10
        fmt             db      "%ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rsi, arr1    ; считаем с 1
        mov     rax, LONG_MIN
        mov     rcx, 1
loop_i:
        cmp     rcx, N
        jg      break_i
        mov     rbx, [rsi]
        cmp     rbx, rax
        jle     next
        mov     rax, rbx
next:
        add     rcx, 2          ; т.к. с чётными, т.е. +2 на каждом шаге
        add     rsi, 8*2
        jmp     loop_i
break_i:
        mov     rdi, fmt
        mov     rsi, rax
        call    printf
        
        leave
        ret
