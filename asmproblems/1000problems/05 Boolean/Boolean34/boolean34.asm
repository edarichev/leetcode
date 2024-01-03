; Boolean34 . Даны координаты поля шахматной доски x , y (целые числа, лежащие в диапазоне 1–8). 
; Учитывая, что левое нижнее поле доски (1, 1) является черным, 
; проверить истинность высказывания: «Данное поле является белым».
;
; Вывод:
; True (3, 4)
; False (3, 5)
extern  printf
section .data
        x               equ     3
        y               equ     5
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
        ; воспользуемся тем, что если x+y - чётное, то оно чёрное
        ; если x+y - нечётное, то оно белое
        mov     rbx, x
        add     rbx, y
        test    rbx, 1          ; если нечёт, т.е. осталась 1, то белое
        jz      out
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
