; Integer6 . Дано двузначное число. Вывести вначале его левую цифру (десятки),
; а затем — его правую цифру (единицы). Для нахождения десятков использовать 
; операцию деления нацело, для нахождения единиц — операцию
; взятия остатка от деления.
;
; Вывод:
; 37: 3 & 7
extern  printf
section .data
        A       equ     37
        strFormat       db      "%d: %d & %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; поделим на 10, тут хватит младших регистров
        mov     al, A
        cbw                     ; al-> ah:al со знаком
        mov     bl, 10
        idiv    bl
        mov     dl, al
        mov     cl, ah
        movsx   rdx, dl
        movsx   rcx, cl

        mov     rdi, strFormat
        mov     rsi, A
        ; rdx, rcx уже есть
        mov     rax, 0          ; кол-во вещественных
        call    printf
        
        leave
        ret
