; Boolean16 . Дано целое положительное число. Проверить истинность высказывания: 
; «Данное число является четным двузначным».
;
; Вывод:
; True (42)
; False (23)
extern  printf
section .data
        A               equ     161
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        xor     rax, rax        ; rax <- false
        ; для усложнения допустим, что есть и отрицательные числа
        mov     rbx, A
        cmp     rbx, 0
        jnl     work
        neg     rbx             ; сделаем из отрицательного положительное
work:
        cmp     rbx, 100
        jge     out             ; не двузначное, >99
        cmp     rbx, 10
        jl      out             ; не двузначное, <10
        ; теперь проверим чётность
        test    rbx, 1          ; последний бит д.б. 0 -> ZF->0
        jnz     out             ; в последнем бите 1, это нечётное
        mov     rax, 1
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
