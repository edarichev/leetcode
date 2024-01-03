; Series33 . Даны целые числа K , N , а также K наборов целых чисел по N элементов
; в каждом наборе. Для каждого набора вывести номер его последнего
; элемента, равного 2, или число 0, если в данном наборе нет двоек.
;
; Вывод:
; S0 -> 4
; S1 -> 0
; S2 -> 2

extern  printf
section .data
        series1         dq      1,2,3,2,5
        series2         dq      6,7,8,9,10
        series3         dq      11,2,13,12,15
        N               equ     5
        K               equ     3
        strFormat       db      "S%d -> %d",10,0
        arr             dq      series1, series2, series3
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, K
        mov     rdi, arr
loop_row:
        test    rcx, rcx
        jz      break_loop_row
        mov     rbx, qword [rdi]
        add     rbx, 8 * N
        sub     rbx, 8          ; установим указатель на последний элемент серии
        mov     rdx, N          ; последний элемент - N-й, т.е. нумерация с 0
        xor     rsi, rsi
        loop_col:
                test    rdx, rdx
                jz      break_loop_col
                cmp     qword [rbx], 2
                jne     next_col
                jmp     break_loop_col
        next_col:
                dec     rdx
                sub     rbx, 8
                jmp     loop_col
        break_loop_col:
        push    rcx
        push    rdi
        
        mov     rdi, strFormat
        mov     rsi, rcx
        call    printf
        
        pop     rdi
        pop     rcx
        
        dec     rcx
        add     rdi, 8
        jmp     loop_row
break_loop_row:
        leave
        ret
