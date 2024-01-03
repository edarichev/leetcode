; Boolean19 . Проверить истинность высказывания: «Среди трех данных целых
; чисел есть хотя бы одна пара взаимно противоположных».
;
; Вывод:
; True (4, 3, -4)
; False (4, 3, 4)
; т.е. 5 и -5, 7 и -7 и т.п.
extern  printf
section .data
        A               equ     3
        B               equ     4
        C               equ     4
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
        ; надо сравнить A, B; A, C; B, C
        mov     rbx, A
        mov     rcx, B
        mov     rdx, C
        
        mov     r8, rcx         ; сделаем копию
        neg     r8              ; и изменим знак
        cmp     rbx, r8
        jne     checkAC
        mov     rax, 1
        jmp     out
checkAC:        
        mov     r8, rdx         ; сделаем копию
        neg     r8              ; и изменим знак
        cmp     rbx, r8
        jne     checkBC
        mov     rax, 1
        jmp     out
checkBC:
        mov     r8, rdx         ; сделаем копию
        neg     r8              ; и изменим знак
        cmp     rcx, r8
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
