; If2 . Дано целое число. Если оно является положительным, то прибавить к нему 1; 
; в противном случае вычесть из него 2. Вывести полученное число.
;
; Вывод:
; -20 -> -22
; 20 -> 21
extern  printf
section .data
        A               equ     -20
        strFormat       db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rdx, A
        cmp     rdx, 0
        jng     lessOr0         ; <= 0
        inc     rdx
        jmp     done
lessOr0:
        sub     rdx, 2
done:
        ; вывод
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, A
        call    printf
        leave
        ret

