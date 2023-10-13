; Boolean13 . Даны три целых числа: A , B , C . Проверить истинность высказывания: 
; «Хотя бы одно из чисел A , B , C положительное».
;
; Вывод:
; True (4, 2, -1)
; False (-2, -3, -1)
extern  printf
section .data
        A               equ     -6
        B               equ     -2
        C               equ     -11
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rax, 1         ; пойдём от противного: ставим в true, чтобы поменьше прыжков
        
        mov     rbx, A
        cmp     rbx, 0
        jg      done            ; сразу на выход - оно положительно
        mov     rbx, B
        cmp     rbx, 0
        jg      done            ; сразу на выход - оно положительно
        mov     rbx, C
        cmp     rbx, 0
        jg      done            ; сразу на выход - оно положительно
        xor     rax, rax        ; неудача, ни одно не положительно
done:
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
