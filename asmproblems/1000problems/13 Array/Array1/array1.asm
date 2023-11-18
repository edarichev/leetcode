; Array1. Дано целое число N (> 0). Сформировать и вывести целочисленный
; массив размера N, содержащий N первых положительных нечетных чисел:
; 1, 3, 5, ... .
;
; Вывод:
; [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]

%include "../../utils.inc"

extern  printf
section .data
        N       equ     10
section .bss
        arr     resq    N
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, N
        mov     rdx, 1
        mov     rsi, arr
loop_i:
        test    rcx, rcx
        jz      exit
        mov     qword [rsi], rdx
        dec     rcx
        add     rdx, 2
        add     rsi, 8
        jmp     loop_i
exit:
        mov     rdi, arr
        mov     rsi, N
        call    PrintInt64Array
        
        leave
        ret
