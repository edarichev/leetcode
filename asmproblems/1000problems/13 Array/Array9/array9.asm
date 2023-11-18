; Array9. Дан целочисленный массив размера N. Вывести все содержащиеся в
; данном массиве четные числа в порядке убывания их индексов, а также их
; количество K.
;
; Вывод:
; 640 160 4 20 2 Count=5

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      3, 2, 5, 1, 20, 4, 99, 160, 321, 640
        fmt             db      "%d ",0
        fmtCount        db      "Count=%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, N
        mov     rsi, arr
        add     rsi, 8 * N - 8          ; в обратном порядке
        mov     rdx, 0
loop_i:
        test    rcx, rcx
        jz      exit
        mov     rax, qword [rsi]
        test    rax, 1
        jnz     next
        inc     rdx
        push    rdx
        push    rcx
        push    rsi
        sub     rsp, 8
        
        mov     rdi, fmt
        mov     rsi, rax
        call    printf
        
        add     rsp, 8
        pop     rsi
        pop     rcx
        pop     rdx
next:
        dec     rcx
        sub     rsi, 8
        jmp     loop_i
exit:
        mov     rdi, fmtCount
        mov     rsi, rdx
        call    printf
        
        leave
        ret
