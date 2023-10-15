; Boolean40 . Даны координаты двух различных полей шахматной доски x 1 , y 1 ,
; x 2 , y 2 (целые числа, лежащие в диапазоне 1–8). Проверить истинность высказывания: 
; «Конь за один ход может перейти с одного поля на другое».
;
; Вывод:
; True (4,4->5,6), (4,4->6,5)
extern  printf
section .data
        x1              equ     4
        y1              equ     4
        x2              equ     6
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
        
        xor     rax, rax        ; <- false
        ; dy==2 && dx==1 или dy==1 && dx==2
        mov     rbx, x1         ; dx=|x1-x2|
        sub     rbx, x2
        mov     rcx, rbx
        neg     rbx
        cmovl   rbx, rcx
        
        mov     rdx, y1         ; dy=|y1-y2|
        sub     rdx, y2
        mov     rcx, rdx
        neg     rdx
        cmovl   rdx, rcx
        
        cmp     rbx, 1
        jne     check2
        cmp     rdx, 2
        jne     out
        mov     rax, 1          ; <- true
        jmp     out
check2:
        cmp     rbx, 2
        jne     out
        cmp     rdx, 1
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
