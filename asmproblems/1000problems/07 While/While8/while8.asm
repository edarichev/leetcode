; While8 . Дано целое число N (> 0). Найти наибольшее целое число K , квадрат
; которого не превосходит N : K^2 ≤ N . Функцию извлечения квадратного корня не использовать.
;
; Вывод:
; K=100

extern  printf
section .data
        N               dq      10000
        strFormat       db      "K=%d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; можно не мудрить, просто перебрать
        mov     rsi, 1
loop_i:
        mov     rdx, rsi
        imul    rdx, rdx
        cmp     rdx, [N]
        jge     done            ; первое, которое == или больше
        inc     rsi
        jmp     loop_i
done:
        mov     rax, 0
        mov     rdi, strFormat
        call    printf
        leave
        ret
