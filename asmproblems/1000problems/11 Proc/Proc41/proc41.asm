; Proc41 . Описать функцию Sin1( x , ε ) вещественного типа (параметры x , ε —
; вещественные, ε > 0), находящую приближенное значение функции sin( x ):
; sin( x ) = x – x^3 /(3!) + x^5 /(5!) – ... + (–1) n · x^2·n+1 /((2· n +1)!) + ... .
; В сумме учитывать все слагаемые, модуль которых больше ε . С помощью
; Sin1 найти приближенное значение синуса для данного x при шести данных ε .
;
; Вывод:
; sin(0.785) = 0.704377
; sin(0.785) = 0.706861
; sin(0.785) = 0.706861
; sin(0.785) = 0.706825
; sin(0.785) = 0.706825
; sin(0.785) = 0.706825


extern  printf

section .data
        x               dq      0.785   ; pi/4 -> 0.707
        e               dq      0.01, 0.001, 0.0001, 0.00001, 0.000001, 0.0000001
        End             dq      $
        strFormat       db      "sin(%g) = %g",10,0
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
        call    Cos1
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
Cos1:
        ; Вход: xmm0 - x
        ;       xmm1 - epsilon
        ; Выход: xmm0
        push    rbp
        mov     rbp, rsp
        ; sin( x ) = x – x^3 /(3!) + x^5 /(5!) – ... + (–1) n · x^2·n+1 /((2· n +1)!) + ... .
        movq    xmm2, xmm0      ; текущий член
        pxor    xmm3, xmm3      ; сумма, начальное == x
        mov     rax, -1
        cvtsi2sd xmm4, rax      ; -1.0
        mov     rcx, 1
        cvtsi2sd xmm6, rcx      ; 1.0
        movq    xmm7, xmm6      ; текущее число для факториала (накапливается)
.calc_sin:
        movq    xmm5, xmm2      ; проверим, не меньше ли текущий член, чем e 
        movq    rax, xmm5       ; dx
        btr     rax, 63         ; IEEE 754, старший бит знаковый, сбросим его
        movq    xmm5, rax       ; |dx|
        cmppd   xmm5, xmm1, 1   ; Ki < e ?
        movq    rax, xmm5
        test    rax, rax
        jnz     .exit
        addsd   xmm3, xmm2
        ; вычислим новый член
        mulsd   xmm2, xmm4      ; * (-1)
        mulsd   xmm2, xmm0      ; *x
        mulsd   xmm2, xmm0      ; *x = ki * x^2
        addsd   xmm7, xmm6      ; n+1
        divsd   xmm2, xmm7      ; /(n+1)
        addsd   xmm7, xmm6      ; n+2
        divsd   xmm2, xmm7      ; /(n+2) -> / 1*2*3=3!, 5! ...
        jmp     .calc_sin
.exit:
        movsd   xmm0, xmm3
        leave
        ret
