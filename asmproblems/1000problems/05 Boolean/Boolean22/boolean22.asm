; Boolean22 . Дано трехзначное число. Проверить истинность высказывания:
; «Цифры данного числа образуют возрастающую или убывающую последовательность».
;
; Вывод:
; True (456)
; True (654)
; False (434)
extern  printf
section .data
        A               equ     544
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; предположим, что цифры просто возрастают
        
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
        ; должно быть: r9b < r8b < cl, т.к. мы смотрим слева направо: 456 -> 4->5->6
        cmp     r9b, r8b
        je      out             ; ни то, ни другое
        jg      check2          ; может, убывает?
        cmp     r8b, cl
        jge     out             ; проверять более не нужно, это и не возр., и не убыв.
        mov     rax, 1
        jmp     out
check2:
        ; а тут проверим, может, это убывающая последовательность
        cmp     r9b, r8b
        jle     out
        cmp     r8b, cl
        jle     out
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
