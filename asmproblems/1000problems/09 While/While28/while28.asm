; While28 . Дано вещественное число ε (> 0). Последовательность вещественных
; чисел A K определяется следующим образом:
; A 1 = 2,
; A K = 2 + 1/ A K–1 , K = 2, 3, ... .
; Найти первый из номеров K , для которых выполняется условие
; | A K – A K–1 | < ε ,
; и вывести этот номер, а также числа A K–1 и A K .
;
; Вывод:
; K=3, A(K-1)=2.4, A(K)=2.41667

extern  printf
section .data
        E               dq      0.05
        strFormat       db      "K=%d, A(K-1)=%g, A(K)=%g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rax, 0x7fffffffffffffff
        movq    xmm6, rax       ; маска для сброса знакового бита в xmm-регистре
        movsd   xmm7, [E]
        mov     rsi, 1          ; rsi == K
        mov     rax, 2
        cvtsi2sd xmm2, rax      ; <- 2.0
        cvtsi2sd xmm1, rsi      ; <- 1.0
        movsd   xmm3, xmm2      ; первое слагаемое
loop_i:
        movsd   xmm4, xmm1      ; <- 1.0
        divsd   xmm4, xmm3      ; 1/A(k-1)
        addsd   xmm4, xmm2      ; 2+... == A(k)
        movsd   xmm5, xmm3
        subsd   xmm5, xmm4
        pand    xmm5, xmm6      ; знаковый бит -> 0
        cmppd   xmm5, xmm7, 1
        movq    rax, xmm5
        test    rax, rax
        jnz     done
        inc     rsi
        movsd   xmm3, xmm4
        jmp     loop_i
done:
        mov     rax, 2
        mov     rdi, strFormat
        ; rsi == K, xmm0 == A(k-1), xmm1 == A(k)
        movsd   xmm0, xmm3
        movsd   xmm1, xmm4
        call    printf
        leave
        ret
