; Boolean9 . Даны два целых числа: A , B . Проверить истинность высказывания:
; «Хотя бы одно из чисел A и B нечетное».
;
; Вывод:
; False (4, 2)
; True (2, 3)
extern  printf
section .data
        A               equ     2
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
        
        xor     rax, rax        ; ставим false изначально
        ; первый метод - проверить бит №0 через биттест или AND 1, или TEST 1
        mov     rbx, A
        xor     rdx, rdx        ; сделаем через битовый тест <- 0-й бит
        bt      rbx, rdx
        jnc     checkB          ; если чётное, проверим B
        mov     rax, 1          ; true
        jmp     done
checkB:
        mov     rbx, B
        test    rbx, 1
        jz      done
        mov     rax, 1
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
