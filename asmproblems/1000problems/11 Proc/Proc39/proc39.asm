; Proc39 . Используя функции Power1 и Power2 (задания Proc37 и Proc38), 
; описать функцию Power3( A , B ) вещественного типа с вещественными 
; параметрами, находящую A^B следующим образом: если B имеет нулевую дробную 
; часть, то вызывается функция Power2( A , N ), где N — переменная 
; целого типа , равная числу B ; иначе вызывается Power1( A , B ). С помощью этой
; функции найти A^P , B^P , C^P , если даны числа P , A , B , C .
;
; Вывод:
; 2^5 = 32
; 2^5.5 = 45.2548

extern  printf

%macro  CALL_POWER1 2
        movq    xmm0, [%2]
        movq    xmm1, xmm0
        roundpd xmm0, xmm0, 3
        cmppd   xmm0, xmm1, 1   ; округлённое < исходного ?
        movq    rax, xmm0
        test    rax, rax
        jnz     go_power1
        

        movq    xmm0, [%1]
        movq    xmm1, [%2]
        cvtsd2si rdi, xmm1
        call    Power2
        mov     rax, 1
        mov     rdi, strFormatd
        movq    xmm1, [%2]
        cvtsd2si rsi, xmm1
        movq    xmm1, xmm0
        movq    xmm0, [%1]
        call    printf
        jmp     exit
go_power1:
        movq    xmm0, [%1]
        movq    xmm1, [%2]
        call    Power1
        mov     rax, 1
        mov     rdi, strFormatg
        movq    xmm2, xmm0
        movq    xmm0, [%1]
        movq    xmm1, [%2]
        call    printf
        jmp     exit

%endmacro

section .data
        A               dq      1.0
        B               dq      2.0
        C               dq      3.0
        P               dq      5.5
        strFormatg      db      "%g^%g = %g",10,0
        strFormatd      db      "%g^%d = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        CALL_POWER1     B, P
exit:
        leave
        ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Power2:
        ; Вход: 
        ;       xmm0 - A
        ;       rdi  - B (степень)
        ; Выход: rax
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        movq    xmm1, xmm0
        cmp     rdi, 0          ; == 0 ?
        je      .set_1
        jl      .set_less0
        ; тут > 0
.loop_pow:
        dec     rdi             ; т.к. 1 степень уже есть
        test    rdi, rdi
        jz      .exit
        mulsd   xmm1, xmm0
        jmp     .loop_pow
.set_less0:
        mov     rax, 1
        cvtsi2sd xmm1, rax
.loop_pow_neg:
        test    rdi, rdi
        jz      .exit
        divsd   xmm1, xmm0
        inc     rdi
        jmp     .loop_pow_neg
.set_1:
        mov     rax, 1
        cvtsi2sd xmm1, rax
.exit:
        movq    xmm0, xmm1
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
