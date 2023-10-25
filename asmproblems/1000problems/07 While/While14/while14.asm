; While14 . Дано число A (> 1). Вывести наибольшее из целых чисел K , для которых 
; сумма 1 + 1/2 + ... + 1/ K будет меньше A , и саму эту сумму.
;
; Вывод:
; N = 3, K = 10, S = 2.92897

extern  printf
section .data
        N               dq      3.0
        strFormat       db      "N = %g, K = %g, S = %g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [N]       ; xmm0 - N
        pxor    xmm2, xmm2      ; xmm2 - S
        mov     rax, 1
        cvtsi2sd xmm1, rax      ; xmm1 - K
        movsd   xmm4, xmm1      ; == 1.0, const
loop_i:
        movsd   xmm3, xmm4      ; <- 1.0
        divsd   xmm3, xmm1      ; 1/K
        movsd   xmm5, xmm2      ; копия S
        addsd   xmm5, xmm3
        movsd   xmm6, xmm5
        cmppd   xmm6, xmm0, 0DH
        movq    rax, xmm6
        test    rax, rax
        jnz     done
        movsd   xmm2, xmm5
        addsd   xmm1, xmm4
        jmp     loop_i
done:
        subsd   xmm1, xmm4      ; -1
        mov     rax, 3
        mov     rdi, strFormat
        ; xmm0 - N
        ; xmm1 - K
        ; xmm2 - S
        call    printf
        leave
        ret
