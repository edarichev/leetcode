; For17 . Дано вещественное число A и целое число N (> 0). Используя один цикл,
; найти сумму
; 1 + A + A^2 + A^3 + ... + A^N .
;
; Вывод:
;  3
; ∑A^i = 15
; i=0
; (при 1 + 2 + 2^2 + 2^3)

extern  printf
section .data
        A               dq      2.0
        Start           equ     0
        N               equ     3
        strFormat       db      "%3d",10," ∑A^i = %g",10," i=%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        pxor    xmm0, xmm0      ; начальная сумма
        mov     rcx, Start      ; счётчик степени, до N
        mov     rbx, N          ; предел счётчика
        mov     rax, 1          ; начальное произведение:
        cvtsi2sd xmm1, rax      ; <- 1, здесь храним A^N (последнее вычисленное)
        movsd   xmm2, [A]       ; копия - сам множитель A, на него будем умножать xmm1
for_loop:
        cmp     rcx, rbx
        jg      done
        
        test    rcx, rcx
        jz      next
        mulsd   xmm1, xmm2      ; ... *A
next:
        addsd   xmm0, xmm1      ; ... + A^i
        inc     rcx
        jmp     for_loop
done:
        mov     rax, 1
        mov     rdi, strFormat
        mov     rsi, N
        ; xmm0 уже есть - это сумма
        mov     rdx, Start
        call    printf
        leave
        ret
