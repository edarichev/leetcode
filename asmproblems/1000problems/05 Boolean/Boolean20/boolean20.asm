; Boolean20 . Дано трехзначное число. Проверить истинность высказывания:
; «Все цифры данного числа различны».
;
; Вывод:
; True (435)
; False (434)
extern  printf
section .data
        A               equ     456
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; сначала выделим цифры
        mov     ax, A           ; хватит 2 байт
        cwd
        mov     bx, 10
        idiv    bx
        mov     cl, dl          ; cl - единицы
        cwd
        idiv    bx
        mov     r8b, dl         ; r8b - десятки
        cwd
        idiv    bx
        mov     r9b, dl         ; r9b - сотни
        
        xor     rax, rax        ; <- False
        ; сравниваем
        cmp     cl, r8b
        je      out
        cmp     cl, r9b
        je      out
        cmp     r8b, r9b
        je      out
        mov     rax, 1          ; <- True
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
