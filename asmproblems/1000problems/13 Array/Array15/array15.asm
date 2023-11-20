;Array15. Дан массив A размера N. Вывести вначале его элементы с нечетными
; номерами в порядке возрастания номеров, а затем — элементы с четными
; номерами в порядке убывания номеров.
; A 1 , A 3 , A 5 , ..., A 6 , A 4 , A 2 .
; Условный оператор не использовать.
;
; Вывод:
; 3 5 20 99 321 11 640 160 4 1 2

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
        ; с нечётными в порядке возрастания
        mov     rcx, 1
        mov     rsi, arr
        
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

        ; с чётными в порядке убывания
        mov     rcx, N-1                ; т.к. N у нас нечётное
        mov     rsi, arr
        add     rsi, N * 8 - 8*2        ; у нас нечётное кол-во, поэтому вычтем 1, чтобы получит предпоследний (чётный №)
loop_j:
        cmp     rcx, 1
        jl      exit_loop_j
        push    rsi
        push    rcx
        
        mov     rdi, fmt
        mov     rsi, qword [rsi]
        call    printf
        
        pop     rcx
        pop     rsi
        sub     rcx, 2
        sub     rsi, 2 * 8
        jmp     loop_j
exit_loop_j:
        mov     rdi, NL
        call    printf
        
        leave
        ret
