; Boolean29 ° . Даны числа x , y , x 1 , y 1 , x 2 , y 2 . Проверить истинность высказывания:
; «Точка с координатами ( x , y ) лежит внутри прямоугольника, левая верхняя
; вершина которого имеет координаты ( x 1 , y 1 ), правая нижняя — ( x 2 , y 2 ),
; а стороны параллельны координатным осям».
;
; Вывод:
; True (5, 2) внутри (1,7) (9, 1)
extern  printf
section .data
        x               equ     5
        y               equ     2
        x1              equ     1
        y1              equ     7
        x2              equ     9
        y2              equ     1
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; здесь не нужны вещественные числа, т.к. корни не ищем
        xor     rax, rax        ; <- false
        ; здесь должно быть: x1 >= x && x <= x2 && y1 >= y && y >= y2
        mov     rbx, x
        cmp     rbx, x1
        jl      out             ; x левее x1
        
        cmp     rbx, x2
        jg      out             ; x правее x2
        
        mov     rbx, y
        cmp     rbx, y1
        jg      out             ; y выше y1
        
        cmp     rbx, y2
        jl      out             ; y ниже y2
        
        mov     rax, 1          ; <- true
out:
        ; вывод: выбираем строку True/False по значению rax
        test    rax, rax
        jnz     setTrue
        mov     rsi, strFalse
        jmp     setFormat
setTrue:
        mov     rsi, strTrue
setFormat:
        mov     rdi, strFormat
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
