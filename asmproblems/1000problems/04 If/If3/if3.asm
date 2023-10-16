; If3 . Дано целое число. Если оно является положительным, то прибавить к нему 1; 
; если отрицательным, то вычесть из него 2; если нулевым, то заменить его на 10. Вывести полученное число.
;
; Вывод:
; -20 -> -22
; 20 -> 21
; 0 -> 10
extern  printf
section .data
        A               equ     0
        strFormat       db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rdx, A
        cmp     rdx, 0
        je      is0
        jl      less0           ; <= 0
        inc     rdx
        jmp     done
is0:
        mov     rdx, 10
        jmp     done
less0:
        sub     rdx, 2
done:
        ; вывод: выбираем строку True/False по значению rax
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, A
        call    printf
        leave
        ret

