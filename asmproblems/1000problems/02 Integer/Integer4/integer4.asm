; Integer4 . Даны целые положительные числа A и B ( A > B ). На отрезке длины A
; размещено максимально возможное количество отрезков длины B (без наложений). 
; Используя операцию деления нацело, найти количество отрезков B , размещенных на отрезке A .
;
; Вывод:
; 126 / 13 = 9
extern  printf
section .data
        A       equ     126
        B       equ     13      ; должно уложиться 9
        strFormat       db      "%d / %d = %d",10,0
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
        movsx   rcx, al
        
        mov     rdi, strFormat
        mov     rsi, A
        mov     rdx, B
        ; rcx уже есть
        mov     rax, 0          ; кол-во вещественных
        call    printf
        
        leave
        ret
