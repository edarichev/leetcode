; Boolean10 ° . Даны два целых числа: A , B . Проверить истинность высказывания:
; «Ровно одно из чисел A и B нечетное».
;
; Вывод:
; False (4, 2)
; True (2, 3)
; False (1, 3) - только одно должно быть
extern  printf
section .data
        A               equ     4
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
        
        ; нужен регистр для подсчёта: 0, 1 или оба числа нечётный
        ; если счётчик == 1, то истина, можно использовать тот же rax
        ; затем сравнить с 1
        xor     rax, rax        ; ставим false изначально
        mov     rbx, A
        test    rbx, 1
        jz      checkB
        inc     rax             ; если нечёт, станет 1
checkB:
        mov     rbx, B
        test    rbx, 1
        jz      done
        inc     rax             ; если и тут нечётный, то будет 2
done:
        cmp     rax, 1          ; должно быть ровно 1
        je      end
        xor     rax, rax        ; иначе ставим false
end:
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
