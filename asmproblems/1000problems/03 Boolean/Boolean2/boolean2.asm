; Boolean2 . Дано целое число A . Проверить истинность высказывания: «Число A является нечетным».
;
; Вывод:
; True (при 19)
extern  printf
section .data
        A               equ     19
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
        test    rax, 1          ; если в конце 1, то оно нечётное
        ; тут и делать больше ничего не нужно - если там 1, то оно нечётное, значит, true

        ; вывод: выбираем строку True/False по значению rax
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
