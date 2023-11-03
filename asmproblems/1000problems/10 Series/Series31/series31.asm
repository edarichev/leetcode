; Series31 . Даны целые числа K , N , а также K наборов целых чисел по N элементов
; в каждом наборе. Найти количество наборов, содержащих число 2. 
; Если таких наборов нет, то вывести 0.
;
; Вывод:
; 2

extern  printf
section .data
        series1         dq      1,2,3,4,5
        series2         dq      6,7,8,9,10
        series3         dq      11,2,13,14,15
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
        mov     rdi, arr
        xor     rsi, rsi        ; кол-во наборов - совпадёт с параметром printf
loop_row:
        test    rcx, rcx
        jz      break_loop_row
        mov     rbx, qword [rdi]
        mov     rdx, N
        loop_col:
                test    rdx, rdx
                jz      break_loop_col
                cmp     qword [rbx], 2
                jne     next_col
                inc     rsi     ; в этом наборе есть, +1 и остановка
                jmp     break_loop_col
        next_col:
                dec     rdx
                add     rbx, 8
                jmp     loop_col
        break_loop_col:
        dec     rcx
        add     rdi, 8
        jmp     loop_row
break_loop_row:
done:
        mov     rdi, strFormat
        ; rsi - кол-во
        call    printf
        leave
        ret
