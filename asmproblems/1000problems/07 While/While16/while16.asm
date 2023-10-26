; While16 . Спортсмен-лыжник начал тренировки, пробежав в первый день 10 км.
; Каждый следующий день он увеличивал длину пробега на P процентов от
; пробега предыдущего дня ( P — вещественное, 0 < P < 50). По данному P
; определить, после какого дня суммарный пробег лыжника за все дни 
; превысит 200 км, и вывести найденное количество дней K (целое) и 
; суммарный пробег S (вещественное число).
;
; Вывод:
; N = 10, P = 5%, K = 63, S = 205.938

extern  printf
section .data
        N               dq      10.0
        N1              dq      200.0
        P               dq      5.0     ; 5%
        strFormat       db      "N = %g, P = %g%%, K = %d, S = %g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rsi, 1          ; rsi - дни, K, начнинаем с 1, т.к. первый день тоже надо включить
        movsd   xmm2, [N]       ; xmm2 - суммарный пробег
        movsd   xmm5, [P]
        mov     rax, 100
        cvtsi2sd xmm4, rax
        divsd   xmm5, xmm4      ; 5 -> 0.05
        movsd   xmm6, [N1]      ; xmm6==N1
loop_i:
        inc     rsi
        movsd   xmm3, xmm2
        mulsd   xmm3, xmm5
        addsd   xmm2, xmm3      ; новый пробег
        movsd   xmm4, xmm2
        cmplepd xmm4, xmm6
        movq    rax, xmm4
        test    rax, rax
        jnz     loop_i
done:
        mov     rax, 3
        mov     rdi, strFormat
        ; rsi - дни, K
        movsd   xmm0, [N]
        movsd   xmm1, [P]
        call    printf
        leave
        ret
