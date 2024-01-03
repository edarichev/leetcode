; While15 . Начальный вклад в банке равен 1000 руб. Через каждый месяц размер
; вклада увеличивается на P процентов от имеющейся суммы 
; ( P — вещественное число, 0 < P < 25). По данному P определить, через сколько 
; месяцев размер вклада превысит 1100 руб., и вывести найденное количество
; месяцев K (целое число) и итоговый размер вклада S (вещественное число).
;
; Вывод:
; N = 1000, P = 5%, K = 2, S = 1102.5

extern  printf
section .data
        N               dq      1000.0
        N1              dq      1100.0
        P               dq      5.0     ; 5%
        strFormat       db      "N = %g, P = %g%%, K = %d, S = %g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        xor     rsi, rsi        ; rsi - месяцы, K
        movsd   xmm2, [N]       ; xmm2 - сумма на счёте
        movsd   xmm5, [P]
        mov     rax, 100
        cvtsi2sd xmm4, rax
        divsd   xmm5, xmm4      ; 5 -> 0.05
        movsd   xmm6, [N1]      ; xmm6==N1
loop_i:
        inc     rsi
        movsd   xmm3, xmm2
        mulsd   xmm3, xmm5
        addsd   xmm2, xmm3      ; новая сумма
        movsd   xmm4, xmm2
        cmplepd xmm4, xmm6
        movq    rax, xmm4
        test    rax, rax
        jnz     loop_i
done:
        mov     rax, 3
        mov     rdi, strFormat
        ; rsi - месяцы, K
        movsd   xmm0, [N]
        movsd   xmm1, [P]
        ; xmm2 - сумма на счёте
        call    printf
        leave
        ret
