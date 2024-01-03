; Proc49 . Учитывая соотношение НОД( A , B , C ) = НОД(НОД( A , B ), C ) и используя 
; функцию GCD2 (см. Proc46), описать функцию GCD3( A , B , C ) целого
; типа, находящую наибольший общий делитель трех целых положительных
; чисел A , B , C . С помощью GCD3 найти наибольшие общие делители троек
; ( A , B , C ), ( A , C , D ) и ( B , C , D ), если даны числа A , B , C , D .
;
; Вывод:
; 10, 15, 40; GCD: 5
; 10, 40, 60; GCD: 10
; 15, 40, 60; GCD: 5

extern  printf
%macro  CALL_GCD3 3
        mov     rdi, [%1]
        mov     rsi, [%2]
        mov     rdx, [%3]
        call    GCD3
        
        mov     rdi, strFormat
        mov     rsi, [%1]
        mov     rdx, [%2]
        mov     rcx, [%3]
        mov     r8, rax
        call    printf
%endmacro
section .data
        A               dq      10
        B               dq      15
        C               dq      40
        D               dq      60
        strFormat       db      "%d, %d, %d; GCD: %d",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        CALL_GCD3       A, B, C
        CALL_GCD3       A, C, D
        CALL_GCD3       B, C, D
exit:
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GCD3:
        ; Вход: rdi - A
        ;       rsi - B
        ;       rdx - C
        ; Выход: rax
        push    rbp
        mov     rbp, rsp

        push    rdx
        sub     rsp, 8
        call    GCD2
        
        add     rsp, 8
        pop     rdi
        mov     rsi, rax
        call    GCD2
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
