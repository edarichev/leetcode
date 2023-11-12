; Proc44 . Описать функцию Arctg1( x , ε ) вещественного типа (параметры x , ε —
; вещественные, | x | < 1, ε > 0), находящую приближенное значение функции
; arctg( x ):
; arctg( x ) = x – x^3 /3 + x^5 /5 – ... + (–1)^n · x^2·n+1 /(2· n +1) + ... .
; В сумме учитывать все слагаемые, модуль которых больше ε . С помощью
; Arctg1 найти приближенное значение arctg( x ) для данного x при шести данных ε .
;
; Вывод:
; arctg(0.785) = 0.669708
; arctg(0.785) = 0.664908
; arctg(0.785) = 0.665467
; arctg(0.785) = 0.665531
; arctg(0.785) = 0.665528
; arctg(0.785) = 0.665527

extern  printf

section .data
        x               dq      0.785   ; -> 0.66
        e               dq      0.01, 0.001, 0.0001, 0.00001, 0.000001, 0.0000001
        End             dq      $
        strFormat       db      "arctg(%g) = %g",10,0
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
        call    Arctg1
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
Arctg1:
        ; Вход: xmm0 - x
        ;       xmm1 - epsilon
        ; Выход: xmm0
        push    rbp
        mov     rbp, rsp
        ; arctg( x ) = x – x^3 /3 + x^5 /5 – ... + (–1)^n · x^2·n+1 /(2· n +1) + ... .
        ; здесь лучше сохранять степень X между проходами
        movsd   xmm7, xmm0      ; xmm7 - сумма
        mov     rax, -1
        mov     rcx, 3          ; он же знаменатель
        movq    xmm2, xmm0      ; текущая степень x == x
        cvtsi2sd xmm6, rax      ; -1.0
.calc:                          ; xmm5, xmm7 - Временные
        mulsd   xmm2, xmm0      ; *x
        mulsd   xmm2, xmm0      ; *x^2
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
        inc     rcx
        addsd   xmm7, xmm3
        jmp     .calc
.exit:
        movsd   xmm0, xmm7
        leave
        ret
