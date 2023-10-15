; Boolean35 . Даны координаты двух различных полей шахматной доски x 1 , y 1 ,
; x 2 , y 2 (целые числа, лежащие в диапазоне 1–8). Проверить истинность высказывания: 
; «Данные поля имеют одинаковый цвет».
;
; Вывод:
; True (3, 4), (2, 5)
; False (3, 4), (2, 6)
extern  printf
section .data
        x1              equ     3
        y1              equ     4
        x2              equ     2
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
        ; воспользуемся тем, что если x+y - чётное, то оно чёрное
        ; если x+y - нечётное, то оно белое
        mov     rbx, x1
        add     rbx, y1
        and     rbx, 1          ; нужен только последний бит

        mov     rcx, x2
        add     rcx, y2
        and     rcx, 1          ; нужен только последний бит
        
        cmp     rbx, rcx        ; должно быть одинаковое число - 0 или 1
        jz      out             ; если 0, то одинаковые
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
