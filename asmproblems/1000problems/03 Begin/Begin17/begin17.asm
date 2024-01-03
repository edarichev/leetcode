; Begin17. Даны три точки A , B , C на числовой оси. Найти длины отрезков AC и BC и их сумму.
;
; Вывод:
; a=-9, b=-4, c=1, |ac|=10, |bc|=5, |ac|+|bc|=15
extern  printf
section .data
        a       dq      -9
        b       dq      -4
        c       dq      1
        strFormat       db      "a=%d, b=%d, c=%d, |ac|=%d, |bc|=%d, |ac|+|bc|=%d",10,0
section .bss
        ac      resq    1       ; переменная для |ac|
        bc      resq    1       ; переменная для |bc|
        acbc    resq    1       ; сумма == |ac|+|bc|
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rax, [c]
        sub     rax, [a]
        mov     [ac], rax

        mov     rbx, [c]
        sub     rbx, [b]
        mov     [bc], rbx
        
        add     rax, rbx        ; ac+bc
        mov     [acbc], rax

        ; выводим
        mov     rdi, strFormat
        mov     rsi, [a]
        mov     rdx, [b]
        mov     rcx, [c]
        mov     r8, [ac]
        mov     r9, [bc]
        push    rax             ; здесь до сих пор |ac+bc|
        mov     rax, 0          ; кол-во вещественных чисел
        call    printf
        and     rsp, 0xFFFFFFFFFFFFFFF0
        
        leave
        ret
