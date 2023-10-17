; If27 . Для данного вещественного x найти значение следующей функции f , принимающей значения целого типа:
;           0, если x < 0,
;f ( x ) =  1, если x принадлежит [0, 1), [2, 3), ...,
;          –1, если x принадлежит [1, 2), [3, 4), ... .
;
; Вывод:
; x=-3, f=0
; x=2, f=1
; x=1.5, f=-1
extern  printf

section .data
        x               dq      3.0
        strFormat       db      "x=%g, f=%g",10,0
section .bss
        f               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        movsd   xmm0, [x]
        movsd   xmm2, xmm0
        pxor    xmm1, xmm1      ; <- 0
        cmppd   xmm0, xmm1, 1   ; xmm0 < 0 ?
        movq    rax, xmm0
        test    rax, rax
        jnz     less0
        movsd   xmm0, xmm2
        cvttsd2si rax, xmm0     ; округление с усечением, MXCSR не используется
        ; далее два пути:
        ; левая граница чётная -> 1
        ; левая граница нечётная -> -1
        test    rax, 1
        jz      even            ; левая граница чётная -> 1
        ; [1, [3, [5,...
        mov     rax, -1
        cvtsi2sd xmm0, rax
        jmp     done
even:
        ; [0, [2, [4, [6....
        mov     rax, 1
        cvtsi2sd xmm0, rax
        jmp     done
less0:
        pxor    xmm0, xmm0      ; <- 0
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
