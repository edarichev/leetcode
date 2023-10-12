; Integer27 . Дни недели пронумерованы следующим образом: 1 — понедельник,
; 2 — вторник, ..., 6 — суббота, 7 — воскресенье. Дано целое число K , лежащее 
; в диапазоне 1–365. Определить номер дня недели для K -го дня года,
; если известно, что в этом году 1 января было субботой.
;
; Вывод:
; 363 -> 4
; 2004, например. K=363 - чт=4
; текст тот же, что и в Integer26
extern  printf
section .data
        K       equ     363
        N       equ     6       ; суббота
        strFormat      db      "%d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     ax, K
        add     ax, N
        dec     ax              ; считаем с 0 - воскресенье, т.к. x%y даст 0, если полная неделя, а ниже добавим 1, если ВС.
        cwd
        mov     bx, 7           ; 7 дней в неделе
        idiv    bx              ; dx - остаток, сколько прошло дней в новой неделе
        movsx   rdx, dx
        cmp     rdx, 0
        jnz     next
        mov     rdx, 7
next:

        ; выводим, всё в нужном порядке в регистрах
        mov     rdi, strFormat
        mov     rsi, K
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
