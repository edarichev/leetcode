; Array28. Дан массив A размера N. Найти минимальный элемент из его элементов с четными номерами: A 2 , A 4 , A 6 , ... .
;
; Вывод:
; 1      (arr)
; -4      (arr1)

%include "../../utils.inc"

extern  printf
section .data
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
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

        mov     rsi, arr + 8    ; считаем с 1
        mov     rax, LONG_MAX
        mov     rcx, 2
loop_i:
        cmp     rcx, N
        jg      break_i
        mov     rbx, [rsi]
        cmp     rbx, rax
        jge     next
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
