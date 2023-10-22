; For23 . Дано вещественное число X и целое число N (> 0). Найти значение выражения
; X – X^3 /(3!) + X^5 /(5!) – ... + (–1) N · X^2·N+1 /((2· N +1)!)
; ( N ! = 1·2·...· N ). Полученное число является приближенным значением
; функции sin в точке X .
;
; Вывод:
; sin(1.5708) = 1
; sin(0.785398) = 0.707107
extern  printf
section .data
        X               dq      0.785398163;1.570796327
        N               equ     10
        strFormat       db      "sin(%g) = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        movsd   xmm3, [X]       ; xmm3 - это итоговая сумма, начинаем с X, затем используем X^2
        movsd   xmm2, xmm3
        mulsd   xmm2, xmm2      ; xmm2 - множитель, X^2
        movsd   xmm4, xmm3      ; xmm4 - это текущая степень X^i, пока == X^1
        mov     rax, 1
        cvtsi2sd xmm0, rax      ; xmm0 - значение факториала, начинаем с 1!, на первом же проходе умножим на 2*3
        mov     rax, 1
        cvtsi2sd xmm1, rax      ; xmm1 - это 1/-1
        mov     rax, 0x8000000000000000
        movq    xmm7, rax       ; xmm7 - это маска для смены знакового бита в xmm1
        mov     rbx, N
        add     rbx, rbx        ; счётчик rcx будет идти до 2N+1
        inc     rbx
        mov     rcx, 1
        ; свободны xmm5, xmm6
for_loop:
        cmp     rcx, rbx
        jg      done
        pxor    xmm1, xmm7      ; начинаем со второго члена, поэтому смена знака идёт первой
        mulsd   xmm4, xmm2      ; степень, * X^2
        inc     rcx
        cvtsi2sd xmm5, rcx
        mulsd   xmm0, xmm5      ; *2 (4, 6, 8, ... чёт)
        inc     rcx
        cvtsi2sd xmm5, rcx
        mulsd   xmm0, xmm5      ; *3 (5, 7, ... нечёт)
        movsd   xmm5, xmm4      ; помещаем числитель==текущая степень
        divsd   xmm5, xmm0      ; делим на знаменатель == текущий факториал
        mulsd   xmm5, xmm1      ; * (+/-1)
        addsd   xmm3, xmm5
        jmp     for_loop
done:
        mov     rax, 2
        mov     rdi, strFormat
        movsd   xmm0, [X]
        movsd   xmm1, xmm3
        call    printf
        leave
        ret
