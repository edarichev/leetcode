; For3 . Даны два целых числа A и B ( A < B ). Вывести в порядке убывания 
; все целые числа, расположенные между A и B (не включая числа A и B ), а также
; количество N этих чисел.
;
; Вывод:
; 14 13 12 11 10 9 8 
; Количество чисел: 7

extern  printf
section .data
        A               equ     7
        B               equ     15
        strFormat       db      "%d ",0
        strFmtCount     db      10,"Количество чисел: %d",10,0
section .bss
        N               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rbx, B
        mov     rcx, A
        sub     rbx, rcx
        dec     rbx             ; -1, т.к. обе границы исключены
        mov     [N], rbx
        cmp     rbx, 0
        jle     break_for       ; N<=0
        ; эмуляция for (expr1; expr2; expr3)
        mov     rcx, B          ; for (rcx = B-1; ... | expr1
        dec     rcx             ; == B-1
do_work:
        cmp     rcx, A          ; ... rcx >= A; ... | expr2
        jle     break_for
        push    rcx             ; rcx изменяется в printf, сохраним его
        mov     rbx, rcx
        mov     rax, 0          ; кол-во вещественных чисел
        mov     rdi, strFormat
        mov     rsi, rbx
        call    printf
        pop     rcx             ; rcx--)            | expr3
        dec     rcx
        jmp     do_work
break_for:
        ; кол-во чисел
        xor     rax, rax
        mov     rdi, strFmtCount
        mov     rsi, [N]
        call    printf
        leave
        ret
