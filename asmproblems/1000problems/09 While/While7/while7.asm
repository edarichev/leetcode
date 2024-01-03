; While7 ° . Дано целое число N (> 0). Найти наименьшее целое положительное
; число K , квадрат которого превосходит N : K^2 > N . Функцию извлечения
; квадратного корня не использовать.
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
        jg      done            ; первое, которое даст больше
        inc     rsi
        jmp     loop_i
done:
        mov     rax, 0
        mov     rdi, strFormat
        call    printf
        leave
        ret
