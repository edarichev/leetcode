; Array5. Дано целое число N (> 2). Сформировать и вывести целочисленный
; массив размера N, содержащий N первых элементов последовательности
; чисел Фибоначчи F K :
; F 1 = 1,
; F 2 = 1,
; F K = F K–2 + F K–1 , K = 3, 4, ... .
;
; Вывод:
; [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]

%include "../../utils.inc"

extern  printf
section .data
        N       equ     10
        A       equ     3
        D       equ     2
section .bss
        arr     resq    N
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 2
        mov     rbx, 1
        mov     rdx, 1
        mov     rsi, arr
        mov     qword [rsi], rbx        ; F1
        add     rsi, 8
loop_i:
        cmp     rcx, N
        jg      exit
        mov     qword [rsi], rdx
        add     rbx, rdx                ; значение следующего члена в rbx, чтобы не заводить лишнюю переменную
        xchg    rbx, rdx                ; поменять, т.к. сложили наоборот
        inc     rcx
        add     rsi, 8
        jmp     loop_i
exit:
        mov     rdi, arr
        mov     rsi, N
        call    PrintInt64Array
        
        leave
        ret
