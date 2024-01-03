; Boolean23 . Дано четырехзначное число. Проверить истинность высказывания:
; «Данное число читается одинаково слева направо и справа налево».
;
; Вывод:
; True (4554)
; False (4347)
extern  printf
section .data
        A               equ     5345
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
        mov     r10b, dl        ; r10b - десятки
        cwd
        idiv    bx
        mov     r8b, dl         ; r8b - сотни
        cwd
        idiv    bx
        mov     r9b, dl         ; r9b - тысячи
        ; сравним с двух сторон: cl == r9b && r10b == r8b
        xor     rax, rax        ; <- False
        cmp     cl, r9b
        jne     out
        cmp     r10b, r8b
        jne     out
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
