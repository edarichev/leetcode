; For24 . Дано вещественное число X и целое число N (> 0). Найти значение выражения
; 1 – X^2 /(2!) + X^4 /(4!) – ... + (–1) N · X^2·N /((2· N )!)
; ( N ! = 1·2·...· N ). Полученное число является приближенным значением
; функции cos в точке X .
;
; Вывод:
; cos(0.785398) = 0.707107
; cos(3.14) = -0.999999
extern  printf
section .data
        X               dq      3.14;0.785398
        N               equ     10
        strFormat       db      "cos(%g) = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; выведем xmm0 == X и xmm1 == общей сумме, тогда распределим регистры так:
        movsd   xmm2, [X]
        mulsd   xmm2, xmm2      ; xmm2 == X^2 для множителя на каждом шаге
        mov     rax, 1
        cvtsi2sd xmm3, rax      ; xmm3 == +/-1 - множиель для смены знака
        movsd   xmm7, xmm3      ; xmm7 == текущее произведение X^i == 1
        mov     rax, 0x8000000000000000
        movq    xmm4, rax       ; xmm4 == маска старшего бита для смены знака через pxor
        movsd   xmm1, xmm3      ; xmm1 == общая сумма, начнём с 1
        movsd   xmm5, xmm3      ; xmm5 == текущий факториал, начнём с 2
        addsd   xmm5, xmm5      ; 2! == 2
        mov     rbx, N
        imul    rbx, rbx        ; rcx до 2N
        mov     rcx, 2          ; начнём с 2
for_loop:
        cmp     rcx, rbx
        jg      done
        pxor    xmm3, xmm4      ; меняем знак
        movsd   xmm6, xmm3      ; xmm6 == текущий член ряда, * (+/-1)
        mulsd   xmm7, xmm2      ; xmm7==X^i * X^2
        mulsd   xmm6, xmm7      ; текущий член * X^N
        divsd   xmm6, xmm5      ; текущий член / факториал
        addsd   xmm1, xmm6      ; добавить текущий член ряда
        inc     rcx             ; факториал считаем для следующего прохода
        cvtsi2sd xmm0, rcx
        mulsd   xmm5, xmm0      ; i! * (n-1)
        inc     rcx
        cvtsi2sd xmm0, rcx
        mulsd   xmm5, xmm0      ; i! * (n-1) * n
        jmp     for_loop
done:
        mov     rax, 2
        mov     rdi, strFormat
        movsd   xmm0, [X]
        call    printf
        leave
        ret
