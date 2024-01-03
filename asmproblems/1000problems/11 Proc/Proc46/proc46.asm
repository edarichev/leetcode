; Proc46 . Описать функцию GCD2( A , B ) целого типа, находящую наибольший
; общий делитель (НОД, greatest common divisor) двух целых положительных 
; чисел A и B , используя алгоритм Евклида :
; НОД( A , 0) = A ,
; НОД( A , B ) = НОД( B , A mod B ), если B ≠ 0;
; где «mod» обозначает операцию взятия остатка от деления. С помощью
; GCD2 найти наибольшие общие делители пар ( A , B ), ( A , C ), ( A , D ), если даны числа A , B , C , D .
;
; Вывод:
; 10, 15 -> GCD = 5
; 10, 45 -> GCD = 5
; 10, 100 -> GCD = 10

extern  printf

%macro  CALL_GCD        2
        mov     rdi, [%1]
        mov     rsi, [%2]
        call    GCD2
        
        mov     rdi, strFormat
        mov     rcx, rax
        mov     rax, 0
        mov     rsi, [%1]
        mov     rdx, [%2]
        call    printf
%endmacro

section .data
        A               dq      10
        B               dq      15
        C               dq      45
        D               dq      100
        strFormat       db      "%d, %d -> GCD = %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        CALL_GCD        A, B
        CALL_GCD        A, C
        CALL_GCD        A, D
exit:
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
