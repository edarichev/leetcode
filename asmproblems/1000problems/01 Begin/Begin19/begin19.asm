; Begin19. Даны координаты двух противоположных вершин прямоугольника:
; ( x 1 , y 1 ), ( x 2 , y 2 ). Стороны прямоугольника параллельны осям координат.
; Найти периметр и площадь данного прямоугольника.
;
; Вывод:
; x1=-2, y1=-1; x2=6, y2=4; P=26; S=40
extern  printf
section .data
        x1      dq      -2
        y1      dq      -1
        x2      dq      6
        y2      dq      4
        strFormat       db      "x1=%d, y1=%d; x2=%d, y2=%d; P=%d; S=%d",10,0
section .bss
        a       resq    1       ; сторона a = x2-x1
        b       resq    1       ; сторона b = y2-y1
        P       resq    1       ; периметр = 2 * (a + b)
        S       resq    1       ; площадь = a*b
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; a
        mov     rax, [x2]
        sub     rax, [x1]
        mov     [a], rax
        ; b
        mov     rbx, [y2]
        sub     rbx, [y1]
        mov     [b], rbx
        ; P
        mov     rcx, rax
        add     rcx, rbx
        imul    rcx, 2
        mov     [P], rcx
        ; S
        imul    rax, rbx        ; a*b
        mov     [S], rax
        
        mov     rax, 0          ; кол-во вещественных чисел
        mov     rdi, strFormat
        mov     rsi, [x1]
        mov     rdx, [y1]
        mov     rcx, [x2]
        mov     r8,  [y2]
        mov     r9,  [P]
        push    qword [S]
        call    printf
        
        leave
        ret
