; Boolean6 . Даны три целых числа: A , B , C . Проверить истинность высказывания: 
; «Справедливо двойное неравенство A < B < C ».
;
; Вывод:
; False (3 < -2 < -10 != true)
extern  printf
section .data
        A               equ     3
        B               equ     -2
        C               equ     -10
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; A < B < C  === A < B && B < C
        xor     rax, rax        ; ставим false изначально
        mov     rbx, A
        mov     rcx, B
        cmp     rbx, rcx
        jge     done            ; второе проверять не нужно
        mov     rbx, C
        cmp     rcx, rbx
        jge     done
        mov     rax, 1
done:
        ; вывод: выбираем строку True/False по значению rax
        test    rax, rax
        jnz     setTrue
        mov     rsi, strFalse
        jmp     setFormat
setTrue:
        mov     rsi, strTrue
setFormat:
        mov     rdi, strFormat
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
