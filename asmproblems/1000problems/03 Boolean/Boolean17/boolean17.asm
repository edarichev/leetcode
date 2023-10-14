; Boolean17 . Дано целое положительное число. Проверить истинность высказывания: 
; «Данное число является нечетным трехзначным».
;
; Вывод:
; True (42)
; False (23)
extern  printf
section .data
        A               equ     -161
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        xor     rax, rax        ; rax <- false
        ; если отрицательно, сделаем положительным
        mov     rbx, A
        cmp     rbx, 0
        jnl     work
        neg     rbx
work:
        ; проверим нечётность
        test    rbx, 1
        jz      out
        ; проверим трёхзначность
        cmp     rbx, 100
        jl      out
        cmp     rbx, 999
        jg      out
        mov     rax, 1
out:
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
