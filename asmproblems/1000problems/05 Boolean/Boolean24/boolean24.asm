; Boolean24 . Даны числа A , B , C (число A не равно 0). Рассмотрев дискриминант
; D = B^2 – 4· A · C , проверить истинность высказывания: 
; «Квадратное уравнение A · x^2 + B · x + C = 0 имеет вещественные корни».
;
; Вывод:
; True (5, -7, 2)
; False (2, 1, 1)
extern  printf
section .data
        A               equ     2
        B               equ     1
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
        
        ; здесь не нужны вещественные числа, т.к. корни не ищем
        xor     rax, rax        ; <- false
        mov     rcx, B
        imul    rcx, rcx
        mov     rbx, 4
        imul    rbx, A
        imul    rbx, C
        sub     rcx, rbx        ; rax <- D
        cmp     rcx, 0
        jl      out
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
