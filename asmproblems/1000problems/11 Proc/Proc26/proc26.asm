; Proc26 . Описать функцию IsPower5( K ) логического типа, возвращающую True,
; если целый параметр K (> 0) является степенью числа 5, и False в противном случае. 
; С ее помощью найти количество степеней числа 5 в наборе из
; 10 целых положительных чисел.
;
; Вывод:
; 4

extern  printf

section .data
        series1         dq      1,2,3,4,5,6,25,125,10
        End             dq      $
        N               equ     10
        strFormat       db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rbx, 0          ; сумма здесь: rbx сохраняется между вызовами
        mov     rsi, series1
loop_i:
        cmp     rsi, End
        jge     break_i
        push    rsi
        sub     rsp, 8
        mov     rdi, [rsi]
        call    IsPower5
        test    rax, rax
        jz      next
        inc     rbx
next:
        add     rsp, 8
        pop     rsi
        add     rsi, 8
        jmp     loop_i
break_i:
        xor     rax, rax
        mov     rdi, strFormat
        mov     rsi, rbx
        call    printf
        leave
        ret

IsPower5:
        ; Вход: 
        ;       rdi - K
        ; Выход: rax: 1, 0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        xor     rax, rax
        cmp     rdi, 1
        je      .pow_5_0        ; 5^0 == 1
        
        mov     rcx, 1
.loop_i_5:
        imul    rcx, 5
        cmp     rcx, rdi
        jg      .exit
        je      .pow_5_0
        jmp     .loop_i_5
.pow_5_0:
        mov     rax, 1          ; ответ: 1
.exit:
        leave
        ret

        
        
        
        
        
        
        
        
        
        
        
