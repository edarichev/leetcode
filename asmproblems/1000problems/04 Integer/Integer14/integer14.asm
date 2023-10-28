; Integer14 . Дано трехзначное число. В нем зачеркнули первую справа цифру и
; приписали ее слева. Вывести полученное число.
;
; Вывод:
; 372 -> 237
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
        ; теперь в ax число в 10 раз меньше исходного
        movsx   rax, ax         ; расширим до полного регистра
        imul    r8, 100         ; сделаем из бывших единиц сотни
        add     rax, r8         ; окончательное число
        mov     rdx, rax

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, A
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
