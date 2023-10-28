; Begin25 . Найти значение функции y = 3·x^6 – 6·x^2 – 7 при данном значении x.
; Вывод:
; x = 1, y = -10
; решим теперь задачу для целых чисел
extern  printf
section .data
        A       equ     3
        B       equ     -6
        C       equ     -7
        x       dq      1
        strFormat       db      "x = %d, y = %d",10,0
section .bss
        a       resq    1
        b       resq    1
        c       resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rax, [x]
        imul    rax, rax        ; ^2
        mov     rbx, rax        ; сохраним квадрат, чтобы получить потом ^6 и для второго члена
        imul    rax, rax        ; ^4
        imul    rax, rbx        ; ^6
        imul    rax, A
        imul    rbx, B          ; тут уже x^2
        add     rax, rbx
        add     rax, C
        
        ; выводим
        mov     rdi, strFormat
        mov     rsi, [x]
        mov     rdx, rax
        mov     rax, 0          ; кол-во вещественных чисел
        call    printf
        
        leave
        ret
