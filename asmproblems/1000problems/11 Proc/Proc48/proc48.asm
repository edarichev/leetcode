; Proc48 . Наименьшее общее кратное (least common multiple) двух целых
; положительных чисел A и B равно A ·( B /НОД( A , B )), где НОД( A , B ) — наибольший 
; общий делитель A и B . Используя функцию GCD2 (см. Proc46), 
; описать функцию LCM2( A , B ) целого типа, находящую наименьшее общее
; кратное чисел A и B . С помощью LCM2 найти наименьшие общие кратные
; пар ( A , B ), ( A , C ), ( A , D ), если даны числа A , B , C , D .
;
; Вывод:
; 10, 15; LCM: 30
; 10, 45; LCM: 90
; 10, 65; LCM: 130

extern  printf
%macro  CALL_LCM 2
        mov     rdi, [%1]
        mov     rsi, [%2]
        call    LCM2
        
        mov     rdi, strFormat
        mov     rsi, [%1]
        mov     rdx, [%2]
        mov     rcx, rax
        mov     rax, 0
        call    printf
%endmacro
section .data
        A               dq      10
        B               dq      15
        C               dq      45
        D               dq      65
        strFormat       db      "%d, %d; LCM: %d",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        CALL_LCM        A, B
        CALL_LCM        A, C
        CALL_LCM        A, D
exit:
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LCM2:
        ; Вход: rdi - A
        ;       rsi - B
        ; Выход: rax
        push    rbp
        mov     rbp, rsp

        push    rdi
        push    rsi
        
        call    GCD2
        mov     rcx, rax
        
        pop     rsi
        pop     rdi
        
        mov     rax, rsi
        cdq
        idiv    rcx
        imul    rax, rdi
        
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
