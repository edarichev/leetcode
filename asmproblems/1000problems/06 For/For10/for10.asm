; For10 . Дано целое число N (> 0). Найти сумму
; 1 + 1/2 + 1/3 + ... + 1/ N
; (вещественное число).
;
; Вывод:
; 10
;  ∑1/n = 2.92897
; n=1

extern  printf
section .data
        A               equ     1
        B               equ     10
        strFormat       db      "%3d",10,"  ∑1/n = %g",10, " n=%d",10 0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; сумму храним в rsi
        mov     rdx, B          ; предельное значение
        mov     rcx, A          ; счётчик
        pxor    xmm0, xmm0      ; сумма ряда = 0
        mov     rax, 1
        cvtsi2sd xmm1, rax      ; 1.0 для числителя
floop:
        cmp     rcx, rdx
        jg      done
        cvtsi2sd xmm2, rcx
        movsd   xmm3, xmm1      ; числитель
        divsd   xmm3, xmm2      ; 1/x
        addsd   xmm0, xmm3
        inc     rcx
        jmp     floop
done:
        mov     rax, 1
        mov     rdi, strFormat
        mov     rsi, B
        ; xmm0 - уже есть, это сумма
        mov     rdx, A
        call    printf
        
        leave
        ret
