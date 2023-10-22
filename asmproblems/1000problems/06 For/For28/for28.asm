; For28 . Дано вещественное число X (| X | < 1) и целое число N (> 0). Найти значение выражения
; 1 + X /2 – 1· X^2 /(2·4) + 1·3· X^3 /(2·4·6) – ... +
; + (–1) N–1 ·1·3·...·(2· N –3)· X^N /(2·4·...·(2· N )).
; Полученное число является приближенным значением функции sqrt(1 + X) .
;
; Вывод:
; sqrt(1 + 0.6) = 1.26491
extern  printf
section .data
        X               dq      0.6
        N               equ     100
        strFormat       db      "sqrt(1 + %g) = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; распределим регистры
        movsd   xmm0, [X]       ; xmm0 == X, он же будет множителем X на каждом шаге
        mov     rcx, 1
        cvtsi2sd xmm1, rcx      ; xmm1 == общая сумма, тут == 1
        mov     rax, -1
        cvtsi2sd xmm2, rax      ; <- -1, при каждом умножении на -1 будет меняться знак
        mov     rcx, 3          ; поскольку в числителе на 2 меньше, то сначала <- 3, затем см. цикл
        mov     rbx, N
        add     rbx, rbx
        ; вычислим второй член, т.к. он выходит из общей схемы
        mov     rax, 2
        cvtsi2sd xmm5, rax
        movsd   xmm4, xmm0      ; xmm4 == произведение == значение текущего члена, т.к. сохраняется полностью между вычислениями
        divsd   xmm4, xmm5
        addsd   xmm1, xmm4
for_loop:
        cmp     rcx, rbx
        jg      done
        sub     rcx, 2          ; для числителя (он нечётный) сначала вычтем 2: например: 3-2==1
        cvtsi2sd xmm5, rcx
        mulsd   xmm4, xmm5      ; теперь умножим числитель
        mulsd   xmm4, xmm0      ; теперь числитель умножим на X
        mulsd   xmm4, xmm2      ; умножим на на +/-1
        add     rcx, 3          ; теперь добавим 3, т.к. до этого вычли 2, это делитель - его в знаменатель: 1+3=4
        cvtsi2sd xmm5, rcx
        divsd   xmm4, xmm5
        addsd   xmm1, xmm4      ; добавим к общей сумме
        inc     rcx             ; 4+1=5
        jmp     for_loop
done:
        mov     rax, 2
        mov     rdi, strFormat
        ; xmm0, xmm1 установлены в вычислении
        call    printf
        leave
        ret
