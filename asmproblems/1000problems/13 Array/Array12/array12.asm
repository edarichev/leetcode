; Array12. Дан массив A размера N (N — четное число). Вывести его элементы с
; четными номерами в порядке возрастания номеров: A 2 , A 4 , A 6 , ..., A N .
; Условный оператор не использовать.
;
; Вывод:
; 2 1 4 160 640

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      3, 2, 5, 1, 20, 4, 99, 160, 321, 640
        fmt             db      "%d ",0
        NL              db      10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rcx, 2
        mov     rsi, arr
        add     rsi, 8          ; по условию - индекс от 1, поэтому -8, но начинаем со 2-го, итого: -8 + 2*8==8
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
        add     rcx, 2
        add     rsi, 2 * 8
        jmp     loop_i
exit:
        mov     rdi, NL
        call    printf
        
        leave
        ret
