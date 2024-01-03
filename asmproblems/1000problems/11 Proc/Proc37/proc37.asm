; Proc37 . Описать функцию Power1( A , B ) вещественного типа, находящую величину 
; A^B по формуле A^B = exp( B ·ln( A )) (параметры A и B — вещественные).
; В случае нулевого или отрицательного параметра A функция возвращает 0.
; С помощью этой функции найти степени A^P , B^P , C^P , если даны числа P , A , B , C .
;
; Вывод:
; 1^5 = 1
; 2^5 = 32
; 3^5 = 243

extern  printf

%macro  CALL_POWER1 2
        movq    xmm0, [%1]
        movq    xmm1, [%2]
        call    Power1
        mov     rax, 1
        mov     rdi, strFormat
        movq    xmm2, xmm0
        movq    xmm0, [%1]
        movq    xmm1, [%2]
        call    printf
%endmacro

section .data
        A               dq      1.0
        B               dq      2.0
        C               dq      3.0
        P               dq      5.0
        strFormat       db      "%g^%g = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        CALL_POWER1     A, P
        CALL_POWER1     B, P
        CALL_POWER1     C, P
        
        leave
        ret

        
Ln:
        ; Вход: xmm0
        ; Выход: xmm0
        section .bss
                .x       resq    1
        section .text
        push    rbp
        mov     rbp, rsp

        movq    qword [.x], xmm0        ; x, to log
        ; ln(x)=ln(2)*log2(x)
        fldln2                          ; загрузить константу ln2
        fld     qword [.x]
        fyl2x                           ; 1*log2(x)
        fstp    qword [.x]
        movq    xmm0, qword [.x]
        leave
        ret
        
Exp:
        ; Вход: xmm0
        ; Выход: xmm0
section .bss
        .result          resq    1
        .x               resq    1
section .text
        push    rbp
        mov     rbp, rsp
        movq    qword [.x], xmm0
        
        finit
        fld     qword [.x]
        fldl2e                  ; Загрузить константу log2(e).
        fmulp   st1,st0         ;st0 = x*log2(e) = tmp1
        fld1
        fscale                  ;st0 = 2^int(tmp1), st1=tmp1
        fxch
        fld1
        fxch                    ;st0 = tmp1, st1=1, st2=2^int(tmp1)

        fprem                   ;st0 = fract(tmp1) = tmp2
        f2xm1                   ;st0 = 2^(tmp2) - 1 = tmp3
        faddp   st1,st0         ;st0 = tmp3+1, st1 = 2^int(tmp1)
        fmulp   st1,st0         ;st0 = 2^int(tmp1) + 2^fract(tmp1) = 2^(x*log2(e))
        fstp    qword [.result]
        movq    xmm0, qword [.result]
        
        leave
        ret

Power1:
        ; Вход: 
        ;       xmm0 - A
        ;       xmm1 - B (степень)
        ; Выход: rax
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        and     rsp, 0xfffffffffffffff0
        sub     rsp, 16         ; выровнять по 16
        movq    [rsp], xmm1
        ; A^B = exp( B ·ln( A ))
        call    Ln
        movq    xmm1, [rsp]
        mulsd   xmm0, xmm1      ; B*ln(A)
        movq    [rsp], xmm0     ; в то же место стека
        call    Exp
        add     rsp, 16
.exit:
        leave
        ret
