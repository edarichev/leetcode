; Proc29 . Описать функцию DigitCount( K ) целого типа, находящую количество
; цифр целого положительного числа K . Используя эту функцию, найти 
; количество цифр для каждого из пяти данных целых положительных чисел.
;
; Вывод:
; 1
; 2
; 3
; 1
; 1

extern  printf

section .data
        series1         dq      1,25,300,4,5
        End             dq      $
        strFormat       db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, series1
loop_i:
        cmp     rsi, End
        jge     break_i
        push    rsi
        sub     rsp, 8
        mov     rdi, [rsi]
        call    DigitCount

        mov     rdi, strFormat
        mov     rsi, rax
        xor     rax, rax
        call    printf
        
        add     rsp, 8
        pop     rsi
        add     rsi, 8
        jmp     loop_i
break_i:
        leave
        ret

DigitCount:
        ; Вход: 
        ;       rdi - K
        ; Выход: rax: 1, 0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        xor     rcx, rcx
        mov     rax, rdi
        mov     rdi, 10
.loop_d_c:
        test    rax, rax
        jz      .exit
        cdq
        idiv    rdi
        inc     rcx
        jmp     .loop_d_c
.exit:
        mov     rax, rcx
        leave
        ret
