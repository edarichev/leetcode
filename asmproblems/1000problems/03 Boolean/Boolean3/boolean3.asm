; Boolean3 . Дано целое число A . Проверить истинность высказывания: «Число A
; является четным».
;
; Вывод:
; False (при 21)
extern  printf
section .data
        A               equ     20
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
        mov     rbx, A
        
        ; проверка - метод с проверкой бита
        xor     rcx, rcx        ; чистим
        mov     rax, 0          ; ставим индекс проверяемого бита в rax (mov - для наглядности)
        bt      rbx, rax
        jnc      isEven         ; чо-то есть, значит, нечётный
        xor     rax, rax        ; 0 соотв. False - это не положительное число
        jmp     done
isEven:
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
