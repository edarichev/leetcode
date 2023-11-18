; Array3. Дано целое число N (> 1), а также первый член A и разность D 
; арифметической прогрессии. Сформировать и вывести массив размера N, 
; содержащий N первых членов данной прогрессии: A, A + D, A + 2·D, A + 3·D, ... .
;
; Вывод:
; [3, 5, 7, 9, 11, 13, 15, 17, 19, 21]          (A=3, D=2)

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
        
        mov     rcx, 1
        mov     rdx, A
        mov     rsi, arr
loop_i:
        cmp     rcx, N
        jg      exit
        mov     qword [rsi], rdx
        mov     rdx, D
        imul    rdx, rcx
        add     rdx, A

        inc     rcx
        add     rsi, 8
        jmp     loop_i
exit:
        mov     rdi, arr
        mov     rsi, N
        call    PrintInt64Array
        
        leave
        ret
