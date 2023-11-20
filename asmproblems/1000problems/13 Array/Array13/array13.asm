; Array13. Дан массив A размера N (N — нечетное число). Вывести его элементы
; с нечетными номерами в порядке убывания номеров: A N , A N–2 , A N–4 , ..., A 1 .
; Условный оператор не использовать.
;
; Вывод:
; 11 321 99 20 5 3

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

        mov     rcx, N
        mov     rsi, arr
        add     rsi, N*8 - 8    ; последний
loop_i:
        cmp     rcx, 1
        jl      exit
        push    rsi
        push    rcx
        
        mov     rdi, fmt
        mov     rsi, qword [rsi]
        call    printf
        
        pop     rcx
        pop     rsi
        sub     rcx, 2
        sub     rsi, 2 * 8
        jmp     loop_i
exit:
        mov     rdi, NL
        call    printf
        
        leave
        ret
