; Proc47 . Используя функцию GCD2 из задания Proc46, описать процедуру
; Frac1( a , b , p , q ), преобразующую дробь a / b к несократимому виду p / q (все
; параметры процедуры — целого типа, a и b — входные, p и q — выходные). 
; Знак результирующей дроби p / q приписывается числителю (то есть
; q > 0). С помощью Frac1 найти несократимые дроби, равные a / b + c / d ,
; a / b + e / f , a / b + g / h (числа a , b , c , d , e , f , g , h даны).
;
; Вывод:
; 10/15 + 45/65 = 53/39
; 10/15 + 75/85 = 79/51
; 10/15 + 95/105 = 11/7

extern  printf

%macro  CALL_FRAC1 4
        mov     rdi, [%1]
        mov     rsi, [%2]
        mov     rdx, [%3]
        mov     rcx, [%4]
        mov     r8, p   ; адрес, out
        mov     r9, q   ; адрес, out
        call    Frac1
        
        mov     rdi, strFormat
        mov     rsi, [%1]
        mov     rdx, [%2]
        mov     rcx, [%3]
        mov     r8,  [%4]
        mov     r9, [p]
        sub     rsp, 8          ; выравнивание
        push    qword [q]
        call    printf
%endmacro

section .data
        A               dq      10
        B               dq      15
        C               dq      45
        D               dq      65
        E               dq      75
        F               dq      85
        G               dq      95
        H               dq      105
        strFormat       db      "%d/%d + %d/%d = %d/%d",10,0
section .bss
        p               resq    1
        q               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        CALL_FRAC1      A, B, C, D
        CALL_FRAC1      A, B, E, F
        CALL_FRAC1      A, B, G, H
exit:
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Frac1:
        ; Вход: rdi - a, rsi - b, rdx - p, rcx - q, r8 - адрес переменной-числителя, r9 - адрес переменной-знаменателя, 
        ; Выход: [r8] - числитель, [r9] - знаменатель
        push    rbp
        mov     rbp, rsp
        
        imul    rdi, rcx
        imul    rdx, rsi
        add     rdi, rdx        ; числитель
        imul    rsi, rcx        ; знаменатель
        push    rdi
        push    rsi
        push    r8
        push    r9
        
        call    GCD2    ; -> rax
        mov     rcx, rax
        
        pop     r9
        pop     r8
        pop     rsi
        pop     rdi
        
        mov     rax, rdi
        cdq
        idiv    rcx
        mov     rdi, rax        ; остаток ушёл, т.к. GCD
        
        mov     rax, rsi
        cdq
        idiv    rcx
        mov     rsi, rax        ; остаток ушёл, т.к. GCD
        
        mov     [r8], rdi
        mov     [r9], rsi
        
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GCD2:
        ; Вход: rdi - A
        ;       rsi - B
        ; Выход: rax
        push    rbp
        mov     rbp, rsp
        ; gcd(p, q)
        ; q==0 ? -> p
        ; k = p%q
        ; gcd(q, k)
        ; p - rdi, q - rsi
        
        mov     rax, rdi
.loop_gcd:
        cmp     rsi, 0
        je      .exit
        mov     rax, rdi
        cdq
        idiv    rsi
        mov     rdi, rsi
        mov     rsi, rdx
        jmp     .loop_gcd
.exit:
        mov     rax, rdi
        leave
        ret
