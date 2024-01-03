; Array2. Дано целое число N (> 0). Сформировать и вывести целочисленный
; массив размера N, содержащий степени двойки от первой до N-й: 2, 4, 8, 16, ... .
;
; Вывод:
; [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]

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
        
        mov     rcx, 1
        mov     rdx, 2
        mov     rsi, arr
loop_i:
        cmp     rcx, N
        jg      exit
        mov     qword [rsi], rdx
        inc     rcx
        shl     rdx, 1  ; == *2
        add     rsi, 8
        jmp     loop_i
exit:
        mov     rdi, arr
        mov     rsi, N
        call    PrintInt64Array
        
        leave
        ret
