; If1 . Дано целое число. Если оно является положительным, то прибавить 
; к нему 1; в противном случае не изменять его. Вывести полученное число.
;
; Вывод:
; -20 -> -20
; 20 -> 21
extern  printf
section .data
        A               equ     20
        strFormat       db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rdx, A
        cmp     rdx, 0
        jng     done
        inc     rdx
done:
        ; вывод: выбираем строку True/False по значению rax
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, A
        call    printf
        leave
        ret

