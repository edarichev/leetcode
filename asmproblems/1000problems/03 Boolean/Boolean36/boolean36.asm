; Boolean36 . Даны координаты двух различных полей шахматной доски x 1 , y 1 ,
; x 2 , y 2 (целые числа, лежащие в диапазоне 1–8). Проверить истинность высказывания: 
; «Ладья за один ход может перейти с одного поля на другое».
;
; Вывод:
; True (3, 4), (3, 5)
; False (3, 4), (2, 6)
extern  printf
section .data
        x1              equ     1
        y1              equ     2
        x2              equ     3
        y2              equ     5
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
        ; это возможно, если x1==x2 || y1==y2
        mov     rbx, x1
        cmp     rbx, x2
        je      out
        mov     rbx, y1
        cmp     rbx, y2
        je      out
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
