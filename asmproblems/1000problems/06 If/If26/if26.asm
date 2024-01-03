; f26 ° . Для данного вещественного x найти значение следующей функции f , принимающей вещественные значения:
;              – x , если x ≤ 0,
;f ( x ) =
;               x^2 , если 0 < x < 2,
;               4, если x ≥ 2.
;
; Вывод:
; x=3.5, f=4
; x=1.5, f=2.25
; x=-3, f=3
extern  printf

section .data
        x               dq      -3.5
        strFormat       db      "x=%g, f=%g",10,0
section .bss
        f               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        movsd   xmm0, [x]
        movsd   xmm1, xmm0
        pxor    xmm2, xmm2      ; <- 0
        cmplepd xmm0, xmm2
        movq    rax, xmm0
        test    rax, rax
        jnz     negativeX       ; <- -x
        ; 0 < x < 2 ???
        mov     rax, 2
        cvtsi2sd xmm2, rax
        movsd   xmm0, xmm1
        cmppd   xmm0, xmm2, 01h ; xmm0 < xmm1
        movq    rax, xmm0
        test    rax, rax
        jnz     between2        ; <- x^2
        mov     rax, 4          ; <- 4
        cvtsi2sd xmm0, rax
        jmp     done
negativeX:
        movsd   xmm0, xmm1      ; xmm1 == x
        mov     rax, 0x8000000000000000
        movq    xmm2, rax
        pxor    xmm0, xmm2      ; сменить старший бит на противоположный
        jmp     done
between2:
        movsd   xmm0, xmm1
        mulsd   xmm0, xmm0
done:
        movsd   [f], xmm0
        ; выводим
        mov     rax, 2          ; кол-во вещественных
        mov     rdi, strFormat
        movsd   xmm0, [x]
        movsd   xmm1, [f]
        call    printf
        leave
        ret
