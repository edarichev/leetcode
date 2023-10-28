; If28 . Дан номер года (положительное целое число). Определить количество
; дней в этом году, учитывая, что обычный год насчитывает 365 дней, а 
; високосный — 366 дней. Високосным считается год, делящийся на 4, за 
; исключением тех годов, которые делятся на 100 и не делятся на 400 
; (например, годы 300, 1300 и 1900 не являются високосными, а 1200 и 2000 — являются).
;
; Вывод:
; Y=2000, N=366
extern  printf

section .data
        Y               dw      2023
        strFormat       db      "Y=%d, N=%d",10,0
section .bss
        N               resw    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     ax, [Y]
        mov     bx, ax
        cwd
        mov     cx, 4
        idiv    cx
        test    dx, dx
        jnz     normal         ; на 4 не делится, не високосный
        ; здесь все, делящиеся на 4
        ; нужно исключить те, что делятся на 100 и не делятся на 400
        mov     ax, bx
        cwd
        mov     cx, 100
        idiv    cx
        test    dx, dx
        jnz     vy
        ; на 100 делится, оно должно делиться на 400, чтобы быть високосным
        mov     ax, bx
        cwd
        mov     cx, 400
        idiv    cx
        test    dx, dx
        jz      vy
        jmp     normal
vy:
        mov     rax, 366
        jmp     done
normal:
        mov     rax, 365
        jmp     done
done:
        ; выводим
        mov     [N], rax
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        movsx   rsi, word [Y]
        movsx   rdx, word [N]
        call    printf
        leave
        ret
