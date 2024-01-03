; Integer9 . Дано трехзначное число. Используя одну операцию деления нацело,
; вывести первую цифру данного числа (сотни).
;
; Вывод:
; 371 -> 37
extern  printf
section .data
        A       equ     371
        strFormat       db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     ax, A
        cwd                     ; dx:ax
        mov     bx, 10
        idiv    bx
        ; остаток - dx, частное - ax
        movsx   rdx, ax

        mov     rdi, strFormat
        mov     rsi, A
        ; rdx уже есть
        mov     rax, 0          ; кол-во вещественных
        call    printf
        
        leave
        ret
