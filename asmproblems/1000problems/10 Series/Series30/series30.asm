; Series30 . Даны целые числа K , N , а также K наборов целых чисел по N 
; элементов в каждом наборе. Для каждого набора вывести сумму его элементов.
;
; Вывод:
; 15
; 40
; 65

extern  printf
section .data
        series1         dq      1,2,3,4,5
        series2         dq      6,7,8,9,10
        series3         dq      11,12,13,14,15
        N               equ     5
        K               equ     3
        strFormat       db      "%d",10,0
        arr             dq      series1, series2, series3
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, K
        mov     rsi, arr
loop_row:
        test    rcx, rcx
        jz      break_loop_row
        mov     rdx, N
        mov     rdi, [rsi]
        xor     rax, rax                ; сумма
        loop_series:
                test    rdx, rdx
                jz      break_loop_series
                mov     rbx, [rdi]
                add     rax, rbx
                add     rdi, 8
                dec     rdx
                jmp     loop_series
        break_loop_series:
        push    rcx
        push    rsi
        
        mov     rsi, rax
        mov     rdi, strFormat
        mov     rax, 0
        call    printf
        
        pop     rsi
        pop     rcx

        add     rsi, 8
        dec     rcx
        jmp     loop_row
break_loop_row:
done:
        leave
        ret
