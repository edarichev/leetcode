; Boolean11 . Даны два целых числа: A , B . Проверить истинность высказывания:
; «Числа A и B имеют одинаковую четность».
;
; Вывод:
; True (4, 2)
; False (2, 3)
; True (1, 3)
extern  printf
section .data
        A               equ     6
        B               equ     2
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; используем al для A и ah для B - их значения должны быть равны
        xor     rax, rax
        mov     rbx, A
        and     rbx, 1
        mov     al, bl          ; тут будет 1, если A было нечётным
        mov     rbx, B
        and     rbx, 1
        mov     ah, bl          ; тут будет 1, если B было нечётным
        xor     al, ah          ; в al должен оказаться 0, если они равны
        not     al              ; но нам нужна true, поэтому инвертируем в 11111111 или 11111110
        and     al, 1           ; и выделяем младший бит - это будет 0 (false) или 1 (true)
        movsx   rax, al


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
