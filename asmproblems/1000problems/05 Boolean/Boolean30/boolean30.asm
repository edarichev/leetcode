; Boolean30 . Даны целые числа a , b , c , являющиеся сторонами некоторого треугольника. 
; Проверить истинность высказывания: «Треугольник со сторонами a , b , c является равносторонним».
;
; Вывод:
; True (5, 5, 5)
extern  printf
section .data
        a               equ     5
        b               equ     5
        c               equ     5
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; здесь не нужны вещественные числа, т.к. корни не ищем
        xor     rax, rax        ; <- false
        ; просто сравнить: a==b==c
        mov     rbx, a          ; держим a и сравниваем его с b и c
        cmp     rbx, b
        jne     out
        cmp     rbx, c
        jne     out
        mov     rax, 1          ; <- true
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
