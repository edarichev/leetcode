; If24 . Для данного вещественного x найти значение следующей функции f , принимающей вещественные значения:
; f ( x ) = 2·sin( x ), если x > 0,
;           6 – x , если x ≤ 0.
;
; Вывод:
; x=1.57, f=1
; x=-1.57, f=7.57
extern  printf

section .data
        x               dq      1.57    ; радианы
        strFormat       db      "x=%g, f=%g",10,0
section .bss
        y               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; половину решим через XMM
        movsd   xmm0, [x]
        movsd   xmm1, xmm0
        pxor    xmm2, xmm2      ; <- 0
        cmplepd xmm0, xmm2
        movq    rax, xmm0
        test    rax, rax
        jz      positiveX
        ; x иначе <= 0
        mov     rax, 6
        cvtsi2sd xmm0, rax
        subsd   xmm0, xmm1
        movsd   [y], xmm0
        jmp     done
positiveX:
        ; а синуса в SSE нет, используем сопроцессор
        finit
        fld     qword [x]
        fsin
        fstp    qword [y]
done:
        ; выводим
        mov     rax, 2          ; кол-во вещественных
        mov     rdi, strFormat
        movsd   xmm0, [x]
        movsd   xmm1, [y]
        call    printf
        leave
        ret
