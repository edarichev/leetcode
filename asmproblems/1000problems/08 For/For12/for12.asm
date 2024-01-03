; For12 ° . Дано целое число N (> 0). Найти произведение
; 1.1 · 1.2 · 1.3 · ...
; ( N сомножителей).
;
; Вывод:
; 10
;  П(1 + i) = 67.0443
; i=1

extern  printf
section .data
        A               dq      1.0
        Step            dq      0.1
        N               equ     10
        strFormat       db      "%3d",10,"  П(1 + i) = %g",10, " i=%g",10 0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, 1          ; счётчик
        mov     rbx, N
        mov     rax, 1
        cvtsi2sd xmm1, rax      ; <- 1
        movsd   xmm0, xmm1      ; 1 = начальное значение произведения
for_loop:
        cmp     rcx, rbx
        jg      done
        addsd   xmm1, [Step]
        mulsd   xmm0, xmm1
        inc     rcx
        jmp     for_loop
done:
        mov     rax, 1
        mov     rdi, strFormat
        mov     rsi, N
        movsd   xmm1, [A]
        call    printf
        
        leave
        ret
