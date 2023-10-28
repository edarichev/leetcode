; For7 . Даны два целых числа A и B ( A < B ). Найти сумму всех целых чисел от A
; до B включительно.
;
; Вывод:
; 10
;  ∑i = 55
; i=1

extern  printf
section .data
        A               equ     1
        B               equ     10
        strFormat       db      "%3d",10,"  ∑i = %d",10, " i=%d",10 0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; сумму храним в rsi
        mov     rdx, B          ; предельное значение
        mov     rcx, A          ; счётчик
        mov     rbx, 0
floop:
        cmp     rcx, rdx
        jg      done
        add     rbx, rcx
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
