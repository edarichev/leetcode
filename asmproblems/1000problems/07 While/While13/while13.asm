; While13 . Дано число A (> 1). Вывести наименьшее из целых чисел K , для которых 
; сумма 1 + 1/2 + ... + 1/ K будет больше A , и саму эту сумму.
;
; Вывод:
; N = 3, K = 11, S = 3.01988

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
        divsd   xmm3, xmm1
        addsd   xmm2, xmm3
        movsd   xmm3, xmm2
        cmppd   xmm3, xmm0, 0EH ; xmm3 > xmm0 ?
        movq    rax, xmm3
        test    rax, rax
        jnz     done
        addsd   xmm1, xmm4      ; + 1.0
        jmp     loop_i
done:
        sub     rcx, rdx
        mov     rax, 3
        mov     rdi, strFormat
        ; xmm0 - N
        ; xmm1 - K
        ; xmm2 - S
        call    printf
        leave
        ret
