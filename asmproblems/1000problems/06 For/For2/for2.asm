; For2 . Даны два целых числа A и B ( A < B ). Вывести в порядке возрастания все
; целые числа, расположенные между A и B (включая сами числа A и B ),
; а также количество N этих чисел.
;
; Вывод:
; 7 8 9 10 11 12 13 14 15 
; Количество чисел: 9

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
        inc     rbx             ; +1, т.к. обе границы включены
        mov     [N], rbx
        ; эмуляция for (expr1; expr2; expr3)
        mov     rcx, A          ; for (rcx = a; ... | expr1
do_work:
        cmp     rcx, B          ; ... rcx <= B; ... | expr2
        jg      break_for
        push    rcx             ; rcx изменяется в printf, сохраним его
        mov     rbx, rcx
        mov     rax, 0          ; кол-во вещественных чисел
        mov     rdi, strFormat
        mov     rsi, rbx
        call    printf
        pop     rcx             ; rcx++)            | expr3
        inc     rcx
        jmp     do_work
break_for:
        ; кол-во чисел
        xor     rax, rax
        mov     rdi, strFmtCount
        mov     rsi, [N]
        call    printf
        leave
        ret
