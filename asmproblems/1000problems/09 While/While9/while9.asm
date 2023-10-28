; While9 . Дано целое число N (> 1). Найти наименьшее целое число K , при котором выполняется неравенство 3^K > N .
;
; Вывод:
; K=4   (при N=79, 3^4=81)
; K=5   (при N=81, т.к. 3^4==81, а надо больше)

extern  printf
section .data
        N               equ     81
        strFormat       db      "K=%d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; т.е. ищем степень 3
        mov     rsi, 0
        mov     rax, 1
loop_i:
        cmp     rax, N
        jg      done
        inc     rsi
        imul    rax, 3
        jmp     loop_i
done:
        mov     rax, 0
        mov     rdi, strFormat
        call    printf
        leave
        ret
