; Proc35 . Описать функцию Fact2( N ) вещественного типа, вычисляющую двойной факториал :
; N!! = 1·3·5·...·N, если N — нечетное;
; N!! = 2·4·6·...·N, если N — четное
; (N > 0 — параметр целого типа; вещественное возвращаемое значение 
; используется для того, чтобы избежать целочисленного переполнения при
; больших значениях N). С помощью этой функции найти двойные факториалы
; пяти данных целых чисел.
;
; Вывод:
; 5!! = 15
; 6!! = 48
; 7!! = 105
; 8!! = 384
; 10!! = 3840

extern  printf

section .data
        series1         dq      5, 6, 7, 8, 10
        End             dq      $
        N               equ     5
        strFormat       db      "%d!! = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, series1
        and     rsp, 0xfffffffffffffff0
loop_i:
        cmp     rsi, End
        jge     break_i
        
        push    rsi
        sub     rsp, 8
        
        mov     rdi, qword [rsi]
        call    Fact2
        
        mov     rdi, strFormat
        ; xmm0 - в результате
        mov     rsi, qword [rsi]
        call    printf
        
        add     rsp, 8
        pop     rsi
        add     rsi, 8
        jmp     loop_i
break_i:
        leave
        ret

Fact2:
        ; Вход: 
        ;       rdi - N
        ; Выход: xmm0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        pxor    xmm0, xmm0      ; 0 - ошибка
        cmp     rdi, 0
        jl      .exit
        ; вообще, тот же факториал, только с шагом 2 и не заходить на 0 и ниже
        mov     rax, 1
        cvtsi2sd xmm0, rax      ; 1 - нач. произведение
.loop_fact:
        cmp     rdi, 0
        jle     .exit
        cvtsi2sd xmm1, rdi
        mulsd   xmm0, xmm1
        sub     rdi, 2
        jmp     .loop_fact
.exit:
        
        leave
        ret
