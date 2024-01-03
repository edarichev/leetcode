; Array11. Дан массив A размера N и целое число K (1 ≤ K ≤ N). Вывести элементы 
; массива с порядковыми номерами, кратными K: A K , A 2·K , A 3·K , ... .
; Условный оператор не использовать.
;
; Вывод:
; 5 4 321       (K=3)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        K               equ     2
        arr             dq      3, 2, 5, 1, 20, 4, 99, 160, 321, 640
        fmt             db      "%d ",0
        NL              db      10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rcx, K
        mov     rsi, arr
        add     rsi, K * 8 - 8      ; по условию - индекс от 1, поэтому
        mov     rdx, 0
        
loop_i:
        cmp     rcx, N
        jg      exit
        push    rsi
        push    rcx
        
        mov     rdi, fmt
        mov     rsi, qword [rsi]
        call    printf
        
        pop     rcx
        pop     rsi
        add     rcx, K
        add     rsi, K * 8
        jmp     loop_i
exit:
        mov     rdi, NL
        call    printf
        
        leave
        ret
