; Boolean32 . Даны целые числа a , b , c , являющиеся сторонами некоторого треугольника. 
; Проверить истинность высказывания: «Треугольник со сторонами a , b , c является прямоугольным».
;
; Вывод:
; True (3, 4, 5)
extern  printf
section .data
        a               equ     3
        b               equ     4
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
        ; в нашем случае должна выполняться теорема Пифагора
        ; в общем случае нам не известно, какая сторона будет гипотенузой
        ; поэтому можно 3 раза сравнить сумму квадратов
        ; сначала всё занесём регистры b,c,d
        mov     rbx, a
        imul    rbx, rbx
        
        mov     rcx, b
        imul    rcx, rcx
        
        mov     rdx, c
        imul    rdx, rdx
        ; теперь сравним суммы квадратов с оставшейся стороной
        mov     r8, rbx
        add     r8, rcx
        cmp     r8, rdx
        je      out             ; a^2+b^2=c^2
        
        mov     r8, rbx
        add     r8, rdx
        cmp     r8, rcx
        je      out             ; a^2+c^2=b^2
        
        mov     r8, rcx
        add     r8, rdx
        cmp     r8, rbx
        je      out             ; b^2+c^2=a^2
        
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
