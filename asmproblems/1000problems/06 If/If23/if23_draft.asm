; If23 . Даны целочисленные координаты трех вершин прямоугольника, стороны
; которого параллельны координатным осям. Найти координаты его четвертой вершины.
; 
; Решение можно оптимизировать (см. if23.asm), здесь оно большое, но более понятное.
; В итоге можно очень много выкинуть
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
        ; иначе 1-2 - горизонталь
        jl      topSide         ; x1 < x2
        ; это нижняя сторона, поэтому т.4 - topRight
        jmp     topRight
topSide:
        ; т.к. это сверху, то т.4. м.б. только bottomLeft
        jmp     bottomLeft
vert:
        mov     rax, [Y1]
        mov     rbx, [Y2]
        cmp     rax, rbx        ; определяем, левая (y1<y2) или правая (y1>y2)
        jl      leftSide
        ; это правая сторона, поэтому т.4 м.б. только topLeft
        jmp     topLeft
leftSide:
        ; поскольку 1-2 - левая, то т.4 может быть только bottomRight
        jmp     bottomRight

        ; по выходу из метки: rax === X4, rbx === Y4
bottomLeft:
        mov     rax, [X1]
        mov     rbx, [Y3]
        jmp     done
topLeft:
        mov     rax, [X3]
        mov     rbx, [Y1]
        jmp     done
topRight:
        mov     rax, [X1]
        mov     rbx, [Y3]
        jmp     done
bottomRight:
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
