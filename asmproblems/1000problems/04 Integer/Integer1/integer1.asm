; Integer1 . Дано расстояние L в сантиметрах. Используя операцию деления нацело, 
; найти количество полных метров в нем (1 метр = 100 см).
;
; Вывод:
; 2456 cm = 24 m
extern  printf
section .data
        CM      equ     100
        L       dq      2456
        strFormat       db      "%d cm = %d m",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rax, [L]
        ; Инструкция div делит два беззнаковых числа. Если операнд 8-разрядный, то div делит регистр AX на операнд, помещая частное в AL, а остаток (по модулю) в AH.
        ; Если операнд 16-разрядный, то инструкция div делит 32-разрядное число в DX:AX на операнд, помещая частное в AX, а остаток в DX.
        ; Если операнд 32-разрядный, div делит 64-битное число в EDX:EAX на операнд, помещая частное в EAX, а остаток в EDX.
        ; И если операнд 64-разрядный, div делит 128-битное число в RDX:RAX на операнд, помещая частное в RAX, а остаток в RDX.
        
        ; операнд div/idiv в 2 раза по разрядности меньше, чем находящееся в rax число
        ; у нас L - 64 бита
        ; здесь оно лезет в eax, поэтому edx просто обнулим:
        xor     edx, edx
        ; делитель тогда 64/2=32-разрядный -> ebx:
        mov     ebx, CM
        idiv    ebx
        ; теперь результат: eax - частное, edx - остаток
        
        mov     rdi, strFormat
        mov     rsi, [L]        ; cm
        mov     rdx, rax        ; m
        mov     rax, 0          ; кол-во вещественных
        call    printf
        
        leave
        ret