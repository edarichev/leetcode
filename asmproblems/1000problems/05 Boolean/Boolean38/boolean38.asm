; Boolean38 . Даны координаты двух различных полей шахматной доски x 1 , y 1 ,
; x 2 , y 2 (целые числа, лежащие в диапазоне 1–8). Проверить истинность высказывания: 
; «Слон за один ход может перейти с одного поля на другое».
;
; Вывод:
; True (1, 2), (3, 4)
extern  printf
section .data
        x1              equ     1
        y1              equ     2
        x2              equ     3
        y2              equ     4
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
        ; слон ходит по диагонали
        ; значит изменение |dx|==|dy|
        mov     rbx, x1
        sub     rbx, x2
        mov     rcx, rbx        ; rbx=|dx|
        neg     rbx
        cmovl   rbx, rcx
        
        mov     rdx, y1
        sub     rdx, y2
        mov     rcx, rdx        ; rdx=|dy|
        neg     rdx
        cmovl   rdx, rcx
        
        cmp     rbx, rdx        ; |dx|==|dy| ?
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
