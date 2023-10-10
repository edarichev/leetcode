; Begin26 . Найти значение функции y = 4·(x–3)^6 – 7·(x–3)^3 + 2 при данном значении x.
; Вывод:
; x = 1, y = 314
; решим и эту задачу для целых чисел
; перепишем так:
; y = A·(x-B)^6 – C·(x–B)^3 + D
extern  printf
section .data
        A       equ     4
        B       equ     3
        C       equ     7
        D       equ     2
        x       dq      1
        strFormat       db      "x = %d, y = %d",10,0
section .bss
        y       resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rax, [x]
        sub     rax, B          ; эта часть повторяется в 2-х местах
        mov     rbx, rax
        imul    rax, rax        ; ^2
        imul    rax, rbx        ; ^3
        mov     rbx, rax        ; для второго члена
        imul    rax, rax        ; ^6
        imul    rax, A
        imul    rbx, C
        sub     rax, rbx
        add     rax, D
        mov     [y], rax        ; y
        
        ; выводим
        mov     rdi, strFormat
        mov     rsi, [x]
        mov     rdx, rax
        mov     rax, 0          ; кол-во вещественных чисел
        call    printf
        
        leave
        ret
