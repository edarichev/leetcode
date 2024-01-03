; Series35. Дано целое число K , а также K наборов ненулевых целых чисел. 
; Признаком завершения каждого набора является число 0. Для каждого набора
; вывести количество его элементов. Вывести также общее количество элементов во всех наборах.
;
; Вывод:
; S0 -> 7
; S1 -> 5
; S2 -> 3

extern  printf
section .data
        series1         dq      1,2,3,2,5,6,7,0
        series2         dq      6,7,8,9,10,0
        series3         dq      11,2,13,0
        K               equ     3
        strFormat       db      "S%d -> %d",10,0
        arr             dq      series1, series2, series3
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        xor     rcx, rcx
        mov     rdi, arr
        xor     r8, r8          ; rsi==сумма
loop_row:
        cmp     rcx, K
        je      break_loop_row
        mov     rbx, qword [rdi]
        xor     rdx, rdx
        loop_col:
                mov     rax, qword [rbx]
                cmp     rax, 0          ; пока != 0
                je      break_loop_col
                add     r8, rax
                add     rbx, 8
                inc     rdx
                jmp     loop_col
        break_loop_col:
        and     rsp, 0xfffffffffffffff0
        push    rcx
        push    rsi
        push    rdi
        push    r8
        
        mov     rdi, strFormat
        mov     rsi, rcx
        call    printf
        
        pop     r8
        pop     rdi
        pop     rsi
        pop     rcx
        
        inc     rcx
        add     rdi, 8
        jmp     loop_row
break_loop_row:
        leave
        ret
