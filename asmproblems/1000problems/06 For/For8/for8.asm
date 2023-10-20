; For8 . Даны два целых числа A и B ( A < B ). Найти произведение всех целых чисел 
; от A до B включительно.
;
; Вывод:
; 10
;  Пi = 3628800
; i=1

extern  printf
section .data
        A               equ     1
        B               equ     10
        strFormat       db      "%3d",10,"  Пi = %d",10, " i=%d",10 0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; сумму храним в rsi
        mov     rdx, B          ; предельное значение
        mov     rcx, A          ; счётчик
        mov     rbx, 1
floop:
        cmp     rcx, rdx
        jg      done
        imul    rbx, rcx
        inc     rcx
        jmp     floop
done:
        mov     rax, 0
        mov     rdi, strFormat
        mov     rsi, B
        mov     rdx, rbx
        mov     rcx, A
        call    printf
        
        leave
        ret
