; Proc31 . Описать функцию IsPalindrome( K ), возвращающую True, если целый
; параметр K (> 0) является палиндромом (то есть его запись читается одинаково 
; слева направо и справа налево), и False в противном случае. С ее
; помощью найти количество палиндромов в наборе из 10 целых положительных чисел. 
; При описании функции можно использовать функции
; DigitCount и DigitN из заданий Proc29 и Proc30.
;
; Вывод:
; 6

extern  printf

section .data
        series1         dq      1,25,121,454,77,12,98,34,676,9  ; 6 шт.
        End             dq      $
        N               equ     10
        strFormat       db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, series1
        mov     rcx, 0          ; кол-во
loop_i:
        cmp     rsi, End
        jge     break_i
        mov     rdi, qword [rsi]
        push    rsi
        push    rcx
        call    IsPalindrome
        pop     rcx
        pop     rsi
        cmp     rax, 0
        je      next
        inc     rcx
next:
        add     rsi, 8
        jmp     loop_i
break_i:
        mov     rdi, strFormat
        mov     rsi, rcx
        call    printf
        leave
        ret

IsPalindrome:
        ; Вход: 
        ;       rdi - K
        ; Выход: rax: 1, 0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp

        mov     rax, rdi
        xor     rsi, rsi        ; перевёрнутое
        mov     rcx, 10
.loop_p:
        test    rax, rax
        jz      .ok             ; число закончилось
        cdq
        idiv    rcx
        imul    rsi, 10
        add     rsi, rdx
        jmp     .loop_p
.ok:
        xor     rax, rax        ; false
        cmp     rsi, rdi
        jne     .exit
        mov     rax, 1          ; true
.exit:
        
        leave
        ret
