; Proc24 . Описать функцию Even( K ) логического типа, возвращающую True, 
; если целый параметр K является четным, и False в противном случае. С ее
; помощью найти количество четных чисел в наборе из 10 целых чисел.
;
; Вывод:
; 5

extern  printf

section .data
        series1         dq      1,2,3,4,5,6,7,8,9,10
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
        call    Even
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

Even:
        ; Вход: 
        ;       rdi - K
        ; Выход: rax: 1, 0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        mov     rax, rdi
        and     rax, 0x1
.exit:
        leave
        ret

        
        
        
        
        
        
        
        
        
        
        
