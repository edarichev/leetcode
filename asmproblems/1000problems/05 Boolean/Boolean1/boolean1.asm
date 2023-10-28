; Boolean1. Дано целое число A . Проверить истинность высказывания: «Число A является положительным».
;
; Вывод:
; False (при -20)
extern  printf
section .data
        A               equ     -20
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; проверяемое
        mov     rax, A
        
        ; проверка
        test    rax, rax
        jns     isPositive      ; Sign Flag не установлен?
        xor     rax, rax        ; 0 соотв. False - это не положительное число
        jmp     done
isPositive:
        mov     rax, 1          ; 1 соотв. True - это положительное число
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

