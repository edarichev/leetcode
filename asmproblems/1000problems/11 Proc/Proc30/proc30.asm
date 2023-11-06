; Proc30 . Описать функцию DigitN( K , N ) целого типа, возвращающую N -ю цифру 
; целого положительного числа K (цифры в числе нумеруются справа налево). 
; Если количество цифр в числе K меньше N , то функция возвращает
; –1. Для каждого из пяти данных целых положительных чисел K 1 , K 2 , ..., K 5
; вызвать функцию DigitN с параметром N , изменяющимся от 1 до 5.
;
; Вывод:
; 1
; 2
; 3
; -1
; 4

extern  printf

section .data
        series1         dq      1,25,300,40,545327
        End             dq      $
        N               equ     5
        strFormat       db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, series1
        mov     rcx, 1          ; N
loop_i:
        cmp     rsi, End
        jge     break_i
        push    rsi
        push    rcx
        mov     rdi, [rsi]
        mov     rsi, rcx
        call    DigitN

        mov     rdi, strFormat
        mov     rsi, rax
        xor     rax, rax
        call    printf
        
        pop     rcx
        pop     rsi
        add     rsi, 8
        inc     rcx             ; N+1
        jmp     loop_i
break_i:
        leave
        ret

DigitN:
        ; Вход: 
        ;       rdi - K
        ;       rsi - N
        ; Выход: rax: 1, 0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp

        mov     rax, rdi
        mov     rcx, rsi
        mov     rsi, 10
.loop_d_c:
        test    rcx, rcx
        jz      .break_d_c
        test    rax, rax
        jz      .break_d_c
        cdq
        idiv    rsi
        mov     rdi, rdx
        dec     rcx
        jmp     .loop_d_c
.break_d_c:
        mov     rax, rdi
        test    rcx, rcx
        jz      .exit
        mov     rax, -1         ; число закончилось, а до N-го числа ещё не дошли -> -1
.exit:
        leave
        ret
