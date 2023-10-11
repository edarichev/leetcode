; Integer12 . Дано трехзначное число. Вывести число, полученное при прочтении
; исходного числа справа налево.
;
; Вывод:
; 372 -> 273
extern  printf
section .data
        A       equ     372
        strFormat      db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        ; единицы
        mov     ax, A
        cwd                     ; ax->dx:ax
        mov     bx, 10
        idiv    bx
        movsx   rdx, dx         ; остаток от деления в dx
        mov     r8, rdx         ; единицы
        ; десятки - теперь в ax число в 10 раз меньшее
        cwd
        idiv    bx              ; bx==10, не изменилось
        movsx   rdx, dx         ; остаток от деления в dx
        mov     r9, rdx         ; десятки
        ; сейчас в ax - сотни
        movsx   rax, ax
        ; собираем в обратную сторону
        imul    r8, 10
        add     r8, r9
        imul    r8, 10
        add     r8, rax
        mov     rdx, r8

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, A
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
