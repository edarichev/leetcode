; Series15 ° . Дано целое число K и набор ненулевых целых чисел; 
; признак его завершения — число 0. Вывести номер первого числа в наборе, большего K .
; Если таких чисел нет, то вывести 0.
;
; Вывод:
; 5

extern  printf
section .data
        series1         dq      1,2,3,4,5,6,7,8,9,10,0
        K               equ     4
        strFormat       db      "%d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, 1          ; номер числа, начнём с 1, чтобы отличить от 0, означающего отсутствие
        mov     rdx, series1
loop_i:
        mov     rax, qword [rdx]
        test    rax, rax
        jz      done
        cmp     rax, K
        jg      found           ; номер будет не 0
        inc     rsi
        add     rdx, 8
        jmp     loop_i
done:
        xor     rsi, rsi        ; номер числа <- 0
found:
        mov     rax, 0
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
