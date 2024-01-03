; Boolean12 . Даны три целых числа: A , B , C . Проверить истинность высказывания: 
; «Каждое из чисел A , B , C положительное».
;
; Вывод:
; True (4, 2, -1)
; False (2, 3, 1)
extern  printf
section .data
        A               equ     6
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
        
        xor     rax, rax        ; ставим в false
        mov     rbx, A
        cmp     rbx, 0
        jl      done            ; выход, false
        
        mov     rbx, B
        cmp     rbx, 0
        jl      done
        
        mov     rbx, C
        cmp     rbx, 0
        jl      done
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
