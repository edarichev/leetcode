; If23 . Даны целочисленные координаты трех вершин прямоугольника, стороны
; которого параллельны координатным осям. Найти координаты его четвертой вершины.
; (Оптимизированная версия)
;
; Вывод:
; 6,1 (2,1; 2,5; 6,5)
; 2,1 (2,5; 6,5; 6,1)
; 2,5 (6,5; 6,1; 2,1)
; 6,5 (6,1; 2,1; 2,5)
extern  printf

section .data
        ; условимся, что вершины нумеруются по часовой стрелке, иначе придётся чрезмерно усложнять
        X1              dq      6;6;2;2
        Y1              dq      1;5;5;1
        X2              dq      2;6;6;2
        Y2              dq      1;1;5;5
        X3              dq      2;2;6;6
        Y3              dq      5;1;1;5
        strFormat       db      "%d, %d",10,0
section .bss
        X4              resq    1;==6;2;2;6
        Y4              resq    1;==5;5;1;1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; нам не известно, какую вершину нужно найти
        ; сначала найдём номер вершины, затем перейдём по нужной метке
        mov     rax, [X1]
        mov     rbx, [X2]
        cmp     rax, rbx
        je      vert            ; x1==x2 только если это вертикальная сторона
        mov     rax, [X1]
        mov     rbx, [Y3]
        jmp     done
vert:
        mov     rax, [X3]
        mov     rbx, [Y1]
        jmp     done
done:
        mov     [X4], rax
        mov     [Y4], rbx
        ; выводим
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, [X4]
        mov     rdx, [Y4]
        call    printf
        leave
        ret
