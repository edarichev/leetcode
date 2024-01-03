; Series16 ° . Дано целое число K и набор ненулевых целых чисел; 
; признак его завершения — число 0. Вывести номер последнего числа 
; в наборе, большего K . Если таких чисел нет, то вывести 0.
;
; Вывод:
; 10

extern  printf
section .data
        series1         dq      1,2,3,4,5,6,7,8,9,10,4,0
        K               equ     4
        strFormat       db      "%d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        xor     rcx, rcx        ; счётчик
        ; нам не известен конец в общем случае, поэтому двигаемся вправо, пока не встретим 0
        mov     rsi, -1        ; номер числа, с 1, чтобы отличить от 0, означающего отсутствие
        mov     rdx, series1
loop_i:
        mov     rax, qword [rdx]
        test    rax, rax
        jz      done
        cmp     rax, K
        jng     next
        mov     rsi, rcx
next:
        inc     rcx
        add     rdx, 8
        jmp     loop_i
done:
        inc     rsi             ; т.к. нумеруем с 1, а начальное значение == -1
        mov     rax, 0
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
