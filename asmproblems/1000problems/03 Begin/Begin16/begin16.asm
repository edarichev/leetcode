; Begin16. Найти расстояние между двумя точками с заданными координатами
; x 1 и x 2 на числовой оси: | x 2 – x 1 |.
;
; Вывод:
; x1=-9, x2=4, |x2-x1|=13
extern  printf
section .data
        x1      dq      -9
        x2      dq      4
        strFormat       db      "x1=%d, x2=%d, |x2-x1|=%d",10,0
section .bss
        len     resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; на этот раз используем целые числа
        mov     rax, [x1]
        mov     rbx, [x2]
        sub     rbx, rax
        ; для нахождения модуля можно использовать такие варианты:
        mov     rcx, rbx        ; сохраним текущее значение rbx
        neg     rbx
        cmovl   rbx, rcx        ; переслать данные из rcx->rbx, если меньше предыдущее значение rbx меньше последнего (SF<>OF)
        mov     [len], rbx
        
        ; ещё способ: abs(x) = (x XOR y) - y, где y = x >> 31 (или 63, смотря какой размер числа)
        ;mov     rcx, rbx        ; y
        ;shr     rcx, 63
        ;mov     rax, rbx        ; <- x
        ;xor     rax, rcx        ; x XOR y
        ;sub     rax, rcx
        ;mov     [len], rax

        mov     rdi, strFormat
        mov     rax, 0          ; нет xmm
        mov     rsi, [x1]
        mov     rdx, [x2]
        mov     rcx, [len]
        call    printf
        
        leave
        ret
