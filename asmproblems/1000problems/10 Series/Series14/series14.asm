; Series14 . Дано целое число K и набор ненулевых целых чисел; 
; признак его завершения — число 0. Вывести количество чисел в наборе, меньших K .
;
; Вывод:
; 3

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
        
        xor     rsi, rsi        ; кол-во
        mov     rdx, series1
loop_i:
        mov     rax, qword [rdx]
        test    rax, rax
        jz      done
        cmp     rax, K
        jnl     next
        inc     rsi
next:
        add     rdx, 8
        jmp     loop_i
done:
        mov     rax, 0
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
