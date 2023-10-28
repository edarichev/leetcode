; Integer11 ° . Дано трехзначное число. Найти сумму и произведение его цифр.
;
; Вывод:
; 372 -> 12, 42
extern  printf
section .data
        A       equ     372
        strFormat      db      "%d -> %d, %d",10,0
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
        ; сумма, поместим её в rdx, по порядку вызова printf
        mov     rdx, rax
        add     rdx, r8
        add     rdx, r9
        ; произведение -> rcx
        mov     rcx, rax
        imul    rcx, r8
        imul    rcx, r9

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, A
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
