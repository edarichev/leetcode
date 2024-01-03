; Array16. Дан массив A размера N. Вывести его элементы в следующем порядке:
; A 1 , A N , A 2 , A N–1 , A 3 , A N–2 , ... .
;
; Вывод:
; 3 11 2 640 5 321 1 160 20 99 4 4 99 20 160 1 321 5 640 2 11 3

%include "../../utils.inc"

extern  printf
section .data
        N               equ     11
        arr             dq      3, 2, 5, 1, 20, 4, 99, 160, 321, 640, 11
        fmt             db      "%d %d ",0
        NL              db      10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 1
        mov     rsi, arr
        mov     rdi, arr + N*8 - 8
loop_i:
        cmp     rcx, N
        jg      exit_loop_i
        push    rsi
        push    rcx
        push    rdi
        sub     rsp, 8
        
        mov     rsi, qword [rsi]
        mov     rdx, qword [rdi]
        mov     rdi, fmt
        call    printf
        
        add     rsp, 8
        pop     rdi
        pop     rcx
        pop     rsi
        add     rcx, 1
        add     rsi, 8
        sub     rdi, 8
        jmp     loop_i
exit_loop_i:

        mov     rdi, NL
        call    printf
        
        leave
        ret
