; Array10. Дан целочисленный массив размера N. Вывести вначале все содержащиеся 
; в данном массиве четные числа в порядке возрастания их индексов,
; а затем — все нечетные числа в порядке убывания их индексов.
;
; Вывод:
; 2 20 4 160 640 Count=5
; 321 99 1 5 3 Count=5

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
        ; все четные числа в порядке возрастания их индексов
        mov     rcx, N
        mov     rsi, arr
        mov     rdx, 0
even_loop_i:
        test    rcx, rcx
        jz      even_exit
        mov     rax, qword [rsi]
        test    rax, 1
        jnz     even_next
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
even_next:
        dec     rcx
        add     rsi, 8
        jmp     even_loop_i
even_exit:
        mov     rdi, fmtCount
        mov     rsi, rdx
        call    printf
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ; все нечетные числа в порядке убывания их индексов.
        mov     rcx, N
        mov     rsi, arr
        add     rsi, 8 * N - 8          ; в обратном порядке
        mov     rdx, 0
odd_loop_i:
        test    rcx, rcx
        jz      exit
        mov     rax, qword [rsi]
        test    rax, 1
        jz      odd_next
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
odd_next:
        dec     rcx
        sub     rsi, 8
        jmp     odd_loop_i
exit:
        mov     rdi, fmtCount
        mov     rsi, rdx
        call    printf
        
        leave
        ret
