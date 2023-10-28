; Boolean31 . Даны целые числа a , b , c , являющиеся сторонами некоторого треугольника. 
; Проверить истинность высказывания: «Треугольник со сторонами a , b , c является равнобедренным».
;
; Вывод:
; True (5, 5, 4)
extern  printf
section .data
        a               equ     3
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
        
        mov     rax, 1          ; <- true
        ; здесь нам надо проверить: a == b || a == c || b == c
        mov     rbx, a
        cmp     rbx, b
        je      out             ; ok, a==b
        cmp     rbx, c
        je      out             ; a==c
        mov     rbx, b
        cmp     rbx, c
        je      out             ; b == c
        xor     rax, rax        ; <- false
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
