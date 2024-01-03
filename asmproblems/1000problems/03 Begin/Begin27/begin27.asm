; Begin27 °. Дано число A. Вычислить A^8 , используя вспомогательную переменную 
; и три операции умножения. Для этого последовательно находить A 2 ,
; A^4 , A^8 . Вывести все найденные степени числа A.
; Вывод:
; A = 4, A^8 = 65536
extern  printf
section .data
        A       equ     4
        strFormat       db      "A = %d, A^8 = %d",10,0
section .bss
        y       resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rax, A
        imul    rax, rax        ; ^2
        imul    rax, rax        ; ^4
        imul    rax, rax        ; ^8
        mov     [y], rax        ; y=A^8
                
        ; выводим
        mov     rdi, strFormat
        mov     rsi, A
        mov     rdx, rax
        mov     rax, 0          ; кол-во вещественных чисел
        call    printf
        
        leave
        ret
