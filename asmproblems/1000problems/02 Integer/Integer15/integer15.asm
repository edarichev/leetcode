; Integer15 . Дано трехзначное число. Вывести число, полученное при перестановке 
; цифр сотен и десятков исходного числа (например, 123 перейдет в 213).
;
; Вывод:
; 123 -> 213
extern  printf
section .data
        A       equ     123
        strFormat      db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     ax, A
        cwd
        mov     bx, 10
        idiv    bx              ; ->dx:ax
        movsx   rdx, dx
        mov     r8, rdx         ; сохраним единицы
        ; получим десятки - частное в ax
        cwd
        idiv    bx
        movsx   rdx, dx
        mov     r9, rdx         ; сохраним десятки
        ; в ax - сотни
        movsx   rax, ax
        imul    r9, 10          ; сдвинем десятки влево
        add     r9, rax         ; справа добавим бывшие сотни, теперь они станут десятками
        imul    r9, 10
        add     r9, r8          ; вернём единицы
        mov     rdx, r9

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, A
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
