; nteger8 ° . Дано двузначное число. Вывести число, полученное при перестановке цифр исходного числа.
;
; Вывод:
; 37 -> 73
extern  printf
section .data
        A       equ     37
        strFormat       db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; тут без знака
        mov     al, A
        cbw
        mov     bl, 10
        div     bl
        ; теперь в ah - остаток, al - частное
        mov     bl, ah
        ; всё равно 64 бит нужно при выводе
        movsx   rbx, bl
        imul    rbx, 10
        movsx   rdx, al         ; при выводе нужен rdx, поэтому сразу в него
        add     rdx, rbx

        mov     rdi, strFormat
        mov     rsi, A
        ; rdx уже есть
        mov     rax, 0          ; кол-во вещественных
        call    printf
        
        leave
        ret
