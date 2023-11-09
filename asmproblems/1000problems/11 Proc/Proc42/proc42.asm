; Proc42 . Описать функцию Cos1( x , ε ) вещественного типа (параметры x , ε —
; вещественные, ε > 0), находящую приближенное значение функции cos( x ):
; cos( x ) = 1 – x^2 /(2!) + x^4 /(4!) – ... + (–1) n · x^2·n /((2· n )!) + ... .
; В сумме учитывать все слагаемые, модуль которых больше ε . С помощью
; Cos1 найти приближенное значение косинуса для данного x при шести данных ε .
;
; Вывод:
; cos(0.785) = 0.70771
; cos(0.785) = 0.70771
; cos(0.785) = 0.707385
; cos(0.785) = 0.707385
; cos(0.785) = 0.707388
; cos(0.785) = 0.707388

extern  printf

section .data
        x               dq      0.785   ; pi/4 -> 0.707
        e               dq      0.01, 0.001, 0.0001, 0.00001, 0.000001, 0.0000001
        End             dq      $
        strFormat       db      "cos(%g) = %g",10,0
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
        ; cos( x ) = 1 – x^2 /(2!) + x^4 /(4!) – ... + (–1) n · x^2·n /((2· n )!) + ... .
        mov     rcx, 1
        cvtsi2sd xmm6, rcx      ; 1.0
        movq    xmm2, xmm6      ; текущий член, тут == 1, чтобы получать чётные степени x
        pxor    xmm3, xmm3      ; сумма, начальное == 0
        mov     rax, -1
        cvtsi2sd xmm4, rax      ; -1.0
        pxor    xmm7, xmm7      ; текущее число для факториала (накапливается), начнём с 0, чтобы было чётное
.calc:
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
        divsd   xmm2, xmm7      ; /(n+2)
        jmp     .calc
.exit:
        movsd   xmm0, xmm3
        leave
        ret
