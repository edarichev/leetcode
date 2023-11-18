; Array4. Дано целое число N (> 1), а также первый член A и знаменатель D 
; геометрической прогрессии. Сформировать и вывести массив размера N, 
; содержащий N первых членов данной прогрессии:
; A, A·D, A·D^2 , A·D^3 , ... .
;
; Вывод:
; [3, 6, 12, 24, 48, 96, 192, 384, 768, 1536]   (3, 3*2, 3*2*2, 3*2*2*2, ...)

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
        imul    rdx, D          ; на каждом проходе *D

        inc     rcx
        add     rsi, 8
        jmp     loop_i
exit:
        mov     rdi, arr
        mov     rsi, N
        call    PrintInt64Array
        
        leave
        ret
