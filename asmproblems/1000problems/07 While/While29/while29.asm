; While29 . Дано вещественное число ε (> 0). Последовательность вещественных
; чисел A K определяется следующим образом:
; A 1 = 1,
; A 2 = 2,
; A K = ( A K–2 + 2· A K–1 )/3, K = 3, 4, ... .
; Найти первый из номеров K , для которых выполняется условие
; | A K – A K–1 | < ε ,
; и вывести этот номер, а также числа A K–1 и A K .
;
; Вывод:
; K=5, A(K-1)=1.66667, A(K)=1.77778

extern  printf
section .data
        E               dq      0.1
        strFormat       db      "K=%d, A(K-1)=%g, A(K)=%g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rax, 0x7fffffffffffffff
        movq    xmm4, rax       ; маска для сброса знакового бита в xmm-регистре
        movsd   xmm7, [E]
        mov     rsi, 3          ; rsi == K
        cvtsi2sd xmm3, rsi      ; 3.0 для делителя
        mov     rax, 2
        cvtsi2sd xmm2, rax      ; <- 2.0
        mov     rax, 1
        cvtsi2sd xmm0, rax      ; первое, K-2-е слагаемое
        movsd   xmm1, xmm2      ; второе, k-1-е слагаемое
loop_i:
        movsd   xmm6, xmm1
        mulsd   xmm6, xmm2      ; 2*A(k-1)
        addsd   xmm6, xmm0      ; + A(k-2)
        divsd   xmm6, xmm3      ; A(k)
        movsd   xmm5, xmm6
        subsd   xmm5, xmm1
        pand    xmm5, xmm4      ; abs(xmm5)
        cmppd   xmm5, xmm7, 1
        movq    rax, xmm5
        test    rax, rax
        jnz     done
        inc     rsi
        movsd   xmm0, xmm1
        movsd   xmm1, xmm6
        jmp     loop_i
done:
        mov     rax, 2
        mov     rdi, strFormat
        ; rsi == K, xmm0 == A(k-1), xmm1 == A(k)
        call    printf
        leave
        ret
