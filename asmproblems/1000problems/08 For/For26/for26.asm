; For26 . Дано вещественное число X (| X | < 1) и целое число N (> 0). Найти значение выражения
; X – X^3 /3 + X^5 /5 – ... + (–1) N · X^2·N+1 /(2· N +1).
; Полученное число является приближенным значением функции arctg в точке X .
;
; Вывод:
; atan(0.7071) = 0.615475
extern  printf
section .data
        X               dq      0.7071
        N               equ     100
        strFormat       db      "atan(%g) = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; распределим регистры
        movsd   xmm0, [X]
        pxor    xmm1, xmm1      ; xmm1 == общая сумма == 0
        movsd   xmm2, xmm0      ; 
        mulsd   xmm2, xmm2      ; xmm2 == множитель X^2, const
        mov     rbx, N
        add     rbx, rbx
        inc     rbx             ; 2N+1, const
        mov     rax, 0x8000000000000000
        movq    xmm3, rax       ; xmm3 == маска для смены знака +/-1, const
        mov     rax, 1
        cvtsi2sd xmm4, rax      ; +/-1
        movsd   xmm5, xmm0      ; xmm5 == текущая степень X^i == 1
        mov     rcx, 1
for_loop:
        cmp     rcx, rbx
        jg      done
        movsd   xmm6, xmm4      ; текущий член == +/-1
        mulsd   xmm6, xmm5      ; *X^i
        cvtsi2sd xmm7, rcx
        divsd   xmm6, xmm7
        addsd   xmm1, xmm6
        inc     rcx
        inc     rcx
        mulsd   xmm5, xmm2
        pxor    xmm4, xmm3
        jmp     for_loop
done:
        mov     rax, 2
        mov     rdi, strFormat
        ; xmm0, xmm1 установлены в вычислении
        call    printf
        leave
        ret
