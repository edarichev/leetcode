; Array7o. Дан массив размера N. Вывести его элементы в обратном порядке.
;
; Вывод:
; 640 320 160 80 40 20 10 5 2 3 

%include "../../utils.inc"

extern  printf
section .data
        N       equ     10
        arr     dq      3, 2, 5, 10, 20, 40, 80, 160, 320, 640
        fmt     db      "%d ",0
        NL      db      10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, N
        mov     rsi, arr
        add     rsi, N * 8 - 8
loop_i:
        test    rcx, rcx
        jz      exit
        push    rcx
        push    rsi
        
        mov     rdi, fmt
        mov     rsi, qword [rsi]
        call    printf
        
        pop     rsi
        pop     rcx
        dec     rcx
        sub     rsi, 8
        jmp     loop_i
exit:
        mov     rdi, NL
        call    printf
        
        leave
        ret
