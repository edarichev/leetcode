; Proc45 . Описать функцию Power4( x , a , ε ) вещественного типа (параметры x , a ,
; ε — вещественные, | x | < 1; a , ε > 0), находящую приближенное значение
; функции (1 + x ) a :
; (1 + x )^a = 1 + a · x + a ·( a –1)· x^2 /(2!) + ... + a ·( a –1)·...·( a – n +1)· x^n /( n !) + ... .
; В сумме учитывать все слагаемые, модуль которых больше ε . С помощью
; Power4 найти приближенное значение (1 + x )^a для данных x и a при шести данных ε .
;
; Вывод:
; (1 + 0.785)^2.3 = 3.79908

extern  printf

section .data
        x               dq      0.785   ; -> 3,79112328
        a               dq      2.3
        e               dq      0.01, 0.001, 0.0001, 0.00001, 0.000001, 0.0000001
        End             dq      $
        strFormat       db      "(1 + %g)^%g = %g",10,0
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
        movsd   xmm0, [x]
        movsd   xmm1, [a]
        movsd   xmm2, [rbx]
        call    Power4
        
        mov     rdi, strFormat
        movsd   xmm2, xmm0
        movsd   xmm0, [x]
        movsd   xmm1, [a]
        mov     rax, 3
        call    printf
        
        add     rbx, 8
        jmp     loop_i
exit:
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Power4:
        ; Вход: xmm0 - x
        ;       xmm1 - a
        ;       xmm2 - epsilon
        ; Выход: xmm0
        push    rbp
        mov     rbp, rsp
        ; (1 + x )^a = 1 + a · x + a ·( a –1)· x^2 /(2!) + ... + a ·( a –1)·...·( a – n +1)· x^n /( n !) + ... .
        mov     rax, 1
        cvtsi2sd xmm3, rax      ; 1, здесь сумма
        movq    xmm7, xmm3      ; 1, её вычитаем из a на каждой итерации
        mov     rcx, 1          ; следующее число для факториала
        movq    xmm4, xmm3      ; предыдущий член, тут == 1, его умножаем на a*x/rcx
        movq    xmm6, xmm1      ; a
        
.loop_i:
        ; вычислить следующий член
        mulsd   xmm4, xmm6      ; *a
        mulsd   xmm4, xmm0      ; *x
        cvtsi2sd xmm5, rcx      ; последнее число для n!
        divsd   xmm4, xmm5      ; /n

        movq    xmm5, xmm4
        cmppd   xmm5, xmm2, 1   ; текущий член < e ?
        movq    rax, xmm5
        test    rax, rax
        jnz     .exit
        addsd   xmm3, xmm4
        subsd   xmm6, xmm7
        inc     rcx
        jmp     .loop_i
.exit:
        movq    xmm0, xmm3
        leave
        ret
