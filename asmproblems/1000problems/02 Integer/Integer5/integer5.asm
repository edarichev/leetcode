; Integer5 . Даны целые положительные числа A и B ( A > B ). На отрезке длины A
; размещено максимально возможное количество отрезков длины B (без наложений). 
; Используя операцию взятия остатка от деления нацело, найти
; длину незанятой части отрезка A .
;
; Вывод:
; 120 mod 13 = 3
extern  printf
section .data
        A       equ     120
        B       equ     13
        strFormat       db      "%d mod %d = %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; в этой задаче для разнообразия использую AH, AL
        mov     al, A
        cbw                     ; al -> ax=ah:al с расширением знаком
        mov     bl, B
        idiv    bl              ; частное в AL, а остаток (по модулю) в AH.
        mov     cl, ah
        movsx   rcx, cl
        
        mov     rdi, strFormat
        mov     rsi, A
        mov     rdx, B
        ; rcx уже есть
        mov     rax, 0          ; кол-во вещественных
        call    printf
        
        leave
        ret
