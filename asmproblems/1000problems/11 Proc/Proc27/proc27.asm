; Proc27 . Описать функцию IsPowerN( K , N ) логического типа, возвращающую
; True, если целый параметр K (> 0) является степенью числа N (> 1), и False
; в противном случае. Дано число N (> 1) и набор из 10 целых положительных
; чисел. С помощью функции IsPowerN найти количество степеней числа N в данном наборе.
;
; Вывод:
; 2 (1=2^0 и 4=2^2)

extern  printf

section .data
        series1         dq      1,25,3,4,5,6,25,125,25,10
        End             dq      $
        N               equ     2
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
        mov     rsi, N
        call    IsPowerN
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

IsPowerN:
        ; Вход: 
        ;       rdi - K
        ;       rsi - N
        ; Выход: rax: 1, 0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        xor     rax, rax
        
        mov     rdx, 1
.loop_k_n:
        cmp     rdx, rdi
        je      .pow_k_0
        jg      .exit
        imul    rdx, rsi
        jmp     .loop_k_n
.pow_k_0:
        mov     rax, 1          ; ответ: 1
.exit:
        
        leave
        ret

        
        
        
        
        
        
        
        
        
        
        
