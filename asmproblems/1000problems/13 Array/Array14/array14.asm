; Array14. Дан массив A размера N. Вывести вначале его элементы с четными
; номерами (в порядке возрастания номеров), а затем — элементы с нечетными 
; номерами (также в порядке возрастания номеров):7
; A 2 , A 4 , A 6 , ..., A 1 , A 3 , A 5 , ... .
; Условный оператор не использовать.
;
; Вывод:
; 2 1 4 160 640 3 5 20 99 321 11

%include "../../utils.inc"

extern  printf
section .data
        N               equ     11
        arr             dq      3, 2, 5, 1, 20, 4, 99, 160, 321, 640, 11
        fmt             db      "%d ",0
        NL              db      10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; с чётными
        mov     rcx, 2
        mov     rsi, arr
        add     rsi, 8          ; нумеруем с 1 по условию
loop_i:
        cmp     rcx, N
        jg      exit_loop_i
        push    rsi
        push    rcx
        
        mov     rdi, fmt
        mov     rsi, qword [rsi]
        call    printf
        
        pop     rcx
        pop     rsi
        add     rcx, 2
        add     rsi, 2 * 8
        jmp     loop_i
exit_loop_i:

        ; с нечётными
        mov     rcx, 1
        mov     rsi, arr
loop_j:
        cmp     rcx, N
        jg      exit_loop_j
        push    rsi
        push    rcx
        
        mov     rdi, fmt
        mov     rsi, qword [rsi]
        call    printf
        
        pop     rcx
        pop     rsi
        add     rcx, 2
        add     rsi, 2 * 8
        jmp     loop_j
exit_loop_j:
        mov     rdi, NL
        call    printf
        
        leave
        ret
