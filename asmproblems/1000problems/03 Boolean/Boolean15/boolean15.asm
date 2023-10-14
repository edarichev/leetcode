; Boolean15 . Даны три целых числа: A , B , C . Проверить истинность высказывания: 
; «Ровно два из чисел A , B , C являются положительными».
;
; Вывод:
; True (4, 2, -1)
; False (-2, 3, -1)
extern  printf
section .data
        A               equ     -4
        B               equ     -2
        C               equ     1
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; в rax сделаем счётчик и проверим: если число положительно, то увеличим на 1
        ; в конце в нём должно быть ровно 2
        xor     rax, rax
        mov     rbx, A
        cmp     rbx, 0
        jng     checkB
        inc     rax             ; >0, +1
checkB:
        mov     rbx, B
        cmp     rbx, 0
        jng     checkC
        inc     rax
        cmp     rax, 2          ; реализуем короткую проверку, если 2, то C проверять ни к чему
        je      out
checkC:
        mov     rbx, C
        cmp     rbx, 0
        jng     done
        inc     rax
done:
        cmp     rax, 2          ; если == 2, то
        je      out             ; ненулевое число оставим в rax
        xor     rax, rax
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
