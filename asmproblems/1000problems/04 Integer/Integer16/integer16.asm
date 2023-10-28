; Integer16 . Дано трехзначное число. Вывести число, полученное при перестановке
; цифр десятков и единиц исходного числа (например, 123 перейдет в 132).
;
; Вывод:
; 123 -> 132
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

        ; единицы
        mov     ax, A
        cwd
        mov     bx, 10
        idiv    bx
        movsx   rdx, dx         ; единицы в остатке dx
        mov     r8, rdx         ; сохраним их
        ; десятки - делим ещё раз то, что в ax
        cwd
        idiv    bx
        movsx   rdx, dx         ; тут десятки
        movsx   rax, ax
        imul    rax, 10
        add     rax, r8         ; поставим единицы вперёд
        imul    rax, 10
        add     rdx, rax        ; в конце добавим бывшие десятки, сразу поместим в rdx

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, A
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
