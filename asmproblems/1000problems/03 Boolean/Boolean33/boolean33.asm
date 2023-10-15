; Boolean33 . Даны целые числа a , b , c . Проверить истинность высказывания:
; «Существует треугольник со сторонами a , b , c ».
;
; Вывод:
; True (3, 4, 5)
; False (3,4,8)
extern  printf
section .data
        a               equ     3
        b               equ     4
        c               equ     8
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        xor     rax, rax        ; <- false
        ; условие означает, что сумма двух сторон должна быть больше третьей:
        ; a+b>c && a+c>b && b+c>a
        mov     rbx, a
        mov     rcx, b
        mov     rdx, c
        
        ; a+b>c;
        mov     r8, rbx
        add     r8, rcx
        cmp     r8, rdx
        jle     out
        ; a+c>b;
        mov     r8, rbx
        add     r8, rdx
        cmp     r8, rcx
        jle     out
        ; b+c>a
        mov     r8, rcx
        add     r8, rdx
        cmp     r8, rbx
        jle     out
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
