; For25 . Дано вещественное число X (| X | < 1) и целое число N (> 0). Найти значение выражения
; X – X^2 /2 + X^3 /3 – ... + (–1)^N–1 · X^N / N .
; Полученное число является приближенным значением функции ln в точке
; 1 + X .
;
; Вывод:
; ln(1 + 0.785398) = 0.579641
extern  printf
section .data
        X               dq      0.785398
        N               equ     100
        strFormat       db      "ln(1 + %g) = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; распределим регистры:
        movsd   xmm0, [X]       ; xmm0 == X
        pxor    xmm1, xmm1      ; xmm1 == общая сумма
        mov     rax, 1
        cvtsi2sd xmm2, rax      ; xmm2 == +/-1
        mov     rax, 0x8000000000000000
        movq    xmm3, rax       ; xmm3 == маска для смены знака в pxor
        movsd   xmm4, xmm2      ; xmm4 == произведение, X^i, здесь == 1
        mov     rbx, N
        mov     rcx, 1
for_loop:
        cmp     rcx, rbx
        jg      done
        movsd   xmm7, xmm2      ; текущий член <- +/-1
        mulsd   xmm4, xmm0      ; ...X^i * X
        mulsd   xmm7, xmm4      ; +/-1 * X^i
        cvtsi2sd xmm5, rcx      ; знаменатель == rcx
        divsd   xmm7, xmm5
        addsd   xmm1, xmm7
        inc     rcx
        pxor    xmm2, xmm3
        jmp     for_loop
done:
        mov     rax, 2
        mov     rdi, strFormat
        ; xmm0, xmm1 установлены в вычислении
        call    printf
        leave
        ret
