; Boolean5 . Даны два целых числа: A , B . Проверить истинность высказывания:
; «Справедливы неравенства A ≥ 0 или B < –2».
;
; Вывод:
; True  (при 3, -3)
extern  printf
section .data
        A               equ     -3
        B               equ     -2
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        xor     rax, rax        ; сразу false
        mov     rbx, A          ; проверим A
        cmp     rbx, 0
        jl      checkB          ; тут false, проверим B
        mov     rax, 1          ; true, B можно не проверять
        jmp     done
checkB:
        mov     rbx, B          ; проверим B
        cmp     rbx, -2
        jnl     done            ; B>= -1, на выход, false
        mov     rax, 1          ; true
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
