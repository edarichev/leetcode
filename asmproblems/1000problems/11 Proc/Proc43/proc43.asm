; Proc43 . Описать функцию Ln1( x , ε ) вещественного типа (параметры x , ε —
; вещественные, | x | < 1, ε > 0), находящую приближенное значение функции
; ln(1 + x ):
; ln(1 + x ) = x – x^2 /2 + x^3 /3 – ... + (–1) n · x^n+1 /( n +1) + ... .
; В сумме учитывать все слагаемые, модуль которых больше ε . С помощью
; Ln1 найти приближенное значение ln(1 + x ) для данного x при шести данных ε .
;
; Вывод:
; ln(1 + 0.785) = 0.584612
; ln(1 + 0.785) = 0.578867
; ln(1 + 0.785) = 0.579365
; ln(1 + 0.785) = 0.579423
; ln(1 + 0.785) = 0.579419
; ln(1 + 0.785) = 0.579418


extern  printf

section .data
        x               dq      0.785   ; -> 0,579418415
        e               dq      0.01, 0.001, 0.0001, 0.00001, 0.000001, 0.0000001
        End             dq      $
        strFormat       db      "ln(1 + %g) = %g",10,0
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
        call    Ln1
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
Ln1:
        ; Вход: xmm0 - x
        ;       xmm1 - epsilon
        ; Выход: xmm0
        push    rbp
        mov     rbp, rsp
        ; ln(1 + x ) = x – x^2 /2 + x^3 /3 – ... + (–1) n · x^n+1 /( n +1) + ... .
        ; здесь лучше сохранять степень X между проходами
        pxor    xmm7, xmm7      ; xmm7 - сумма
        mov     rax, -1
        mov     rcx, 1          ; он же знаменатель
        cvtsi2sd xmm2, rax      ; 1.0, текущая степень x, начнём цикл с x, в первом проходе будет +1 и x^1/1
        cvtsi2sd xmm6, rax      ; -1.0
.calc:                          ; xmm5, xmm7 - Временные
        mulsd   xmm2, xmm0      ; *x
        mulsd   xmm2, xmm6      ; *(-1)
        movq    xmm3, xmm2      ; копия степени
        cvtsi2sd xmm4, rcx
        divsd   xmm3, xmm4      ; xmm3 - текущий член , /n
        movq    rax, xmm3
        btr     rax, 63
        movq    xmm5, rax
        cmppd   xmm5, xmm1, 1
        movq    rax, xmm5
        test    rax, rax
        jnz     .exit
        inc     rcx
        addsd   xmm7, xmm3
        jmp     .calc
.exit:
        movsd   xmm0, xmm7
        leave
        ret
