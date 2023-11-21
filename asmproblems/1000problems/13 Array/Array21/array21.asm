; Array21. Дан массив размера N и целые числа K и L (1 ≤ K ≤ L ≤ N). Найти
; среднее арифметическое элементов массива с номерами от K до L включительно.
;
; Вывод:
; 25            (129/5=25.8)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        K               equ     3
        L               equ     7
        arr             dq      3, 2, 5, 1, 20, 4, 99, 160, 321, 20
        fmt             db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, K
        mov     rsi, arr
        add     rsi, 8*K - 8            ; т.к. с 1
        mov     rbx, 0                  ; ответ
loop_i:
        cmp     rcx, L
        jg      exit_loop_i
        add     rbx, [rsi]
next_i:
        inc     rcx
        add     rsi, 8
        jmp     loop_i
exit_loop_i:
        ; среднее = x/(L-K+1)
        mov     rax, rbx
        cdq
        mov     rbx, L
        sub     rbx, K
        inc     rbx
        idiv    rbx
        
        mov     rdi, fmt
        mov     rsi, rax
        call    printf
        
        leave
        ret
