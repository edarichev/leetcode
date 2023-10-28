; Boolean4 . Даны два целых числа: A , B . Проверить истинность высказывания:
; «Справедливы неравенства A > 2 и B ≤ 3».
;
; Вывод:
; True (при 3 и 3, иначе False)
extern  printf
section .data
        A               equ     3
        B               equ     3
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; хотя тут очевидно, что A==B, но сделаем ветвление
        ; проверяем
        xor     rax, rax        ; поставим сразу false
        mov     rbx, A
        cmp     rbx, 2
        jg      checkB          ; если больше, проверим B
        jmp     done            ; иначе B не проверяем, rax <- 0
checkB:
        mov     rbx, B
        cmp     rbx, 3
        jg      done            ; B>3, выход
        mov     rax, 1          ; rax <- true

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
