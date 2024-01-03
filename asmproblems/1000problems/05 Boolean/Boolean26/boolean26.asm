; Boolean26 . Даны числа x , y . Проверить истинность высказывания: 
; «Точка с координатами ( x , y ) лежит в четвертой координатной четверти».
;
; Вывод:
; True (5, -1)
; False (2, 1)
extern  printf
section .data
        x               equ     5
        y               equ     1
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; здесь не нужны вещественные числа, т.к. корни не ищем
        xor     rax, rax        ; <- false
        mov     rbx, x
        cmp     rbx, 0
        jl      out             ; II/III
        mov     rbx, y
        cmp     rbx, 0
        jg      out             ; I/II
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
