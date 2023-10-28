; Integer7 . Дано двузначное число. Найти сумму и произведение его цифр.
;
; Вывод:
; 37: 3 & 7: 10, 21
extern  printf
section .data
        A       equ     37
        strFormat       db      "%d: %d & %d: %d, %d",10,0
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
        ; сумма
        mov     r8, rdx
        add     r8, rcx
        ; произведение
        mov     r9, rdx
        imul    r9, rcx

        mov     rdi, strFormat
        mov     rsi, A
        ; rdx, rcx, r8, r9 уже есть
        mov     rax, 0          ; кол-во вещественных
        call    printf
        
        leave
        ret
