; Proc40 . Описать функцию Exp1( x , ε ) вещественного типа (параметры x , ε —
; вещественные, ε > 0), находящую приближенное значение функции exp( x ):
; exp( x ) = 1 + x + x^2 /(2!) + x^3 /(3!) + ... + x^n /( n !) + ...
; ( n ! = 1·2·...· n ). В сумме учитывать все слагаемые, большие ε . С помощью
; Exp1 найти приближенное значение экспоненты для данного x при шести
; данных ε .
;
; Вывод:
; exp(2) = 7.38095
; exp(2) = 7.38871
; exp(2) = 7.38899
; exp(2) = 7.38905
; exp(2) = 7.38906
; exp(2) = 7.38906


extern  printf

section .data
        x               dq      2.0
        e               dq      0.01, 0.001, 0.0001, 0.00001, 0.000001, 0.0000001
        End             dq      $
        strFormat       db      "exp(%g) = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rbx, e
loop_i:
        cmp     rbx, End
        jge     exit
        movq    xmm0, [x]
        movq    xmm1, qword [rbx]       ; e
        call    Exp1
        mov     rax, 2
        mov     rdi, strFormat
        movq    xmm1, xmm0
        movq    xmm0, [x]
        call    printf
        add     rbx, 8
        inc     rcx
        jmp     loop_i
exit:
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Exp1:
        ; Вход: xmm0 - x
        ;       xmm1 - epsilon
        push    rbp
        mov     rbp, rsp
        ; exp( x ) = 1 + x + x^2 /(2!) + x^3 /(3!) + ... + x^n /( n !) + ...
        mov     rax, 1
        cvtsi2sd xmm2, rax      ; ==1, первый член ряда
        pxor    xmm4, xmm4      ; сумма
        mov     rcx, 1
.loop_exp:
        ; найдём разницу между e и новым членом
        movq    rax, xmm2       ; dx
        btr     rax, 63         ; IEEE 754, старший бит знаковый, сбросим его
        movq    xmm3, rax       ; |dx|
        cmppd   xmm3, xmm1, 1   ; dx < e ?
        movq    rax, xmm3
        test    rax, rax
        jnz     .exit           ; dx < e -> exit
        addsd   xmm4, xmm2
        cvtsi2sd xmm5, rcx
        divsd   xmm2, xmm5
        mulsd   xmm2, xmm0
        inc     rcx
        jmp     .loop_exp
.exit:
        movq    xmm0, xmm4
        leave
        ret
