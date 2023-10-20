; For1 . Даны целые числа K и N ( N > 0). Вывести N раз число K .
;
; Вывод:
; -1 -1 -1 -1 -1 -1 -1 
extern  printf
section .data
        N               equ     7
        K               equ     -1
        strFormat       db      "%d ",0
        NL              db      10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rbx, K
        mov     rcx, N
do_work:
        push    rcx             ; rcx изменяется в printf, сохраним его
        mov     rax, 0          ; кол-во вещественных чисел
        mov     rdi, strFormat
        mov     rsi, rbx
        call    printf
        pop     rcx
        loop    do_work         ; loop уменьшает на 1 rcx
done:
        ; перенос строки в конце
        mov     rax, 0          ; кол-во вещественных чисел
        mov     rdi, NL
        call    printf
        leave
        ret
