; For13 ° . Дано целое число N (> 0). Найти значение выражения
; 1.1 – 1.2 + 1.3 – ...
; ( N слагаемых, знаки чередуются). Условный оператор не использовать.
;
; Вывод:
; 10
;  ∑ = -0.5
; i=1

extern  printf
section .data
        A               dq      1.0
        Step            dq      0.1
        N               equ     10
        strFormat       db      "%3d",10,"  ∑ = %g",10, " i=%g",10 0
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
        pxor    xmm0, xmm0      ; 1 = начальное значение суммы == 0
        movsd   xmm3, xmm1      ; знаковый множитель
        mov     rax, 0x8000000000000000 ; для смены знака
        movq    xmm4, rax
for_loop:
        cmp     rcx, rbx
        jg      done
        addsd   xmm1, [Step]
        movsd   xmm2, xmm1
        mulsd   xmm2, xmm3      ; смена знака
        addsd   xmm0, xmm2
        ; сменить знак в xmm3
        pxor    xmm3, xmm4      ; сменить старший бит на противоположный
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
