; Series32 . Даны целые числа K , N , а также K наборов целых чисел по N элементов
; в каждом наборе. Для каждого набора вывести номер его первого 
; элемента, равного 2, или число 0, если в данном наборе нет двоек.
;
; Вывод:
; S0 -> 2
; S1 -> 0
; S2 -> 4

extern  printf
section .data
        series1         dq      1,2,3,4,5
        series2         dq      6,7,8,9,10
        series3         dq      11,12,13,2,15
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
        xor     rcx, rcx
        mov     rdi, arr
loop_row:
        cmp     rcx, K
        je      break_loop_row
        mov     rbx, qword [rdi]
        xor     rdx, rdx
        xor     rsi, rsi
        loop_col:
                cmp     rdx, N
                je      break_loop_col
                cmp     qword [rbx], 2
                jne     next_col
                jmp     break_loop_col
        next_col:
                inc     rdx
                add     rbx, 8
                jmp     loop_col
        break_loop_col:
        push    rcx
        push    rdi
        
        cmp     rdx, N
        jne     write
        mov     rdx, -1         ; тогда при +1 получим 0
write:
        inc     rdx             ; т.к. отсчёт с 1
        mov     rdi, strFormat
        mov     rsi, rcx
        call    printf
        
        pop     rdi
        pop     rcx
        
        inc     rcx
        add     rdi, 8
        jmp     loop_row
break_loop_row:
        leave
        ret
