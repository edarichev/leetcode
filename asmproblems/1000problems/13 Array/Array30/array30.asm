; Array30. Дан массив размера N. Найти номера тех элементов массива, которые
; больше своего правого соседа, и количество таких элементов. Найденные
; номера выводить в порядке их возрастания.
;
; Вывод:
; [2, 4, 6, 8]     (arr)
; [1, 3]           (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      -3, 2, -5, 1, -20, 4, -99, 160, -321, 20
        arr1            dq      1,-2,3,-4,5,6,7,8,9,10
section .bss
        indexes         resq    N       ; будем помещать сюда
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rsi, arr       ; считаем с 1
        mov     rcx, 1
        mov     r8, 0           ; число найденных номеров
        mov     rax, [rsi]
        add     rsi, 8
        mov     rdi, indexes
loop_i:
        cmp     rcx, N-1
        jg      break_i
        mov     rbx, [rsi]
        cmp     rax, rbx
        jl      next
        mov     [rdi], rcx
        inc     r8
        add     rdi, 8
next:
        mov     rax, rbx        ; предыдущий
        inc     rcx
        add     rsi, 8
        jmp     loop_i
break_i:
        mov     rdi, indexes
        mov     rsi, r8
        call    PrintInt64Array
        
        leave
        ret
