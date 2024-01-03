; For27 . Дано вещественное число X (| X | < 1) и целое число N (> 0). Найти значение выражения
; X + 1· X^3 /(2·3) + 1·3· X^5 /(2·4·5) + ... +
; + 1·3·...·(2· N –1)· X^2·N+1 /(2·4·...·(2· N )·(2· N +1)).
; Полученное число является приближенным значением функции arcsin в точке X .
;
; Вывод:
; asin(0.7071) = 0.785389
extern  printf
section .data
        X               dq      0.7071
        N               equ     100
        strFormat       db      "asin(%g) = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; распределим регистры
        movsd   xmm0, [X]
        movsd   xmm1, xmm0      ; xmm1 == общая сумма
        movsd   xmm2, xmm0
        mulsd   xmm2, xmm2      ; xmm2 == множитель X^2
        mov     rcx, 1
        cvtsi2sd xmm3, rcx      ; xmm3 == множитель перед членом, == (2N+1)!!/(2N)!!
        movsd   xmm6, xmm0      ; произведение X^i
        ; в цикле считать начнём со второго члена ряда
        xor     rcx, rcx        ; поставим 0, чтобы цикл был однообразным
        mov     rbx, N
        add     rbx, rbx
        inc     rbx
for_loop:
        cmp     rcx, rbx
        jg      done
        inc     rcx
        cvtsi2sd xmm4, rcx
        mulsd   xmm3, xmm4      ; числитель, нечёт
        inc     rcx
        cvtsi2sd xmm4, rcx
        divsd   xmm3, xmm4      ; знаменатель, чёт
        movsd   xmm5, xmm3      ; текущий член ряда
        mulsd   xmm6, xmm2      ; X^i * X^2
        mulsd   xmm5, xmm6
        inc     rcx
        cvtsi2sd xmm4, rcx
        divsd   xmm5, xmm4
        dec     rcx             ; уменьшим, т.к. это число нужно в следующем проходе
        addsd   xmm1, xmm5
        jmp     for_loop
done:
        mov     rax, 2
        mov     rdi, strFormat
        ; xmm0, xmm1 установлены в вычислении
        call    printf
        leave
        ret
