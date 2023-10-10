; Begin28 . Дано число A. Вычислить A 15 , используя две вспомогательные 
; переменные и пять операций умножения. Для этого последовательно находить
; A^2 , A^3 , A^5 , A^10 , A^15 . Вывести все найденные степени числа A.
; Вывод:
; A = 2, A^2=4, A^3=8, A^5=32, A^10=1024, A^15=32768
extern  printf
section .data
        A       equ     2
        strFormat       db      "A = %d, A^2=%d, A^3=%d, A^5=%d, A^10=%d, A^15=%d",10,0
section .bss
        a2      resq    1
        a3      resq    1
        a5      resq    1
        a10     resq    1
        a15     resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; вспомогательные - rcx, rbx
        mov     rax, A
        mov     rbx, A          ; ^1
        imul    rax, rax        ; ^2    (1)
        mov     [a2], rax
        mov     rcx, rax        ; ^2
        imul    rax, rbx        ; ^3    (2)
        mov     [a3], rax
        imul    rax, rcx        ; ^5    (3)
        mov     rcx, rax        ; ^5
        mov     [a5], rax
        imul    rax, rax        ; ^10   (4)
        mov     [a10], rax
        imul    rax, rcx        ; ^15   (5)
        mov     [a15], rax
                
        ; выводим
        mov     rdi, strFormat
        mov     rsi, A
        mov     rdx, [a2]
        mov     rcx, [a3]
        mov     r8, [a5]
        mov     r9, [a10]
        push    qword [a15]
        mov     rax, 0          ; кол-во вещественных чисел
        call    printf
        
        leave
        ret
