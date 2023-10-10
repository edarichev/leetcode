; Begin21. Даны координаты трех вершин треугольника: ( x 1 , y 1 ), ( x 2 , y 2 ), ( x 3 , y 3 ).
; Найти его периметр и площадь, используя формулу для расстояния между
; двумя точками на плоскости (см. задание Begin20). Для нахождения площади 
; треугольника со сторонами a , b , c использовать формулу Герона :
; S = sqrt(p ⋅ ( p − a ) ⋅ ( p − b ) ⋅ ( p − c )),
; где p = (a + b + c)/2 — полупериметр.
; 
; при данных: a=7,211102551, b=17,088007491, c=16,970562748
; p=41,26967279÷2, S=60
; Вывод:
; (-9, 4); (-3, 8); (3, -8); L=41.2697; S=60
extern  printf
section .data
        x1      dq      -9.0
        y1      dq      4.0
        x2      dq      -3.0
        y2      dq      8.0
        x3      dq      3.0
        y3      dq      -8.0
        strFormat       db      "(%g, %g); (%g, %g); (%g, %g); L=%g; S=%g",10,0
section .bss
        p       resq    1       ; переменная для полупериметра
        L       resq    1       ; переменная для периметра
        S       resq    1       ; переменная для площади
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; a, b, c поместим в xmm/4/5/6
        movsd   xmm0, [x1]
        movsd   xmm1, [y1]
        movsd   xmm2, [x2]
        movsd   xmm3, [y2]
        call    distance
        movsd   xmm4, xmm0      ; a (1_2)

        movsd   xmm0, [x2]
        movsd   xmm1, [y2]
        movsd   xmm2, [x3]
        movsd   xmm3, [y3]
        call    distance
        movsd   xmm5, xmm0      ; b (2_3)

        movsd   xmm0, [x1]
        movsd   xmm1, [y1]
        movsd   xmm2, [x3]
        movsd   xmm3, [y3]
        call    distance
        movsd   xmm6, xmm0      ; c (1_3)
        
        ; полупериметр - в xmm7
        movsd   xmm7, xmm4
        addsd   xmm7, xmm5
        addsd   xmm7, xmm6
        movsd   [L], xmm7       ; L
        mov     rax, 2
        cvtsi2sd xmm0, rax
        divsd   xmm7, xmm0      ; p=L/2
        movsd   [p], xmm7
        
        ; площадь: S = p ⋅ ( p − a ) ⋅ ( p − b ) ⋅ ( p − c ); xmm4,5,6,7 заняты
        movsd   xmm0, xmm7
        subsd   xmm0, xmm4      ; p-a
        mulsd   xmm0, xmm7      ; (p-a)*p
        movsd   xmm1, xmm7
        subsd   xmm1, xmm5      ; p-b
        mulsd   xmm0, xmm1      ; (p-a)*p*(p-b)
        movsd   xmm1, xmm7
        subsd   xmm1, xmm6      ; p-c
        mulsd   xmm0, xmm1      ; (p-a)*p*(p-b)*(p-c)
        sqrtsd  xmm0, xmm0      ; S
        movsd   [S], xmm0

        ; выводим
        movsd   xmm0, [x1]
        movsd   xmm1, [y1]
        movsd   xmm2, [x2]
        movsd   xmm3, [y2]
        movsd   xmm4, [x3]
        movsd   xmm5, [y3]
        movsd   xmm6, [L]
        movsd   xmm7, [S]
        mov     rax, 8          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
distance:
        ; вычисляет длину отрезка по двум точкам
        ; xmm0 - x1
        ; xmm1 - y1
        ; xmm2 - x2
        ; xmm3 - y2
        ; результат: xmm0
        push    rbp
        mov     rbp, rsp
        
        subsd   xmm2, xmm0      ; x2-x1
        mulsd   xmm2, xmm2      ; ^2
        
        subsd   xmm3, xmm1      ; y2-y1
        mulsd   xmm3, xmm3      ; ^2
        
        addsd   xmm2, xmm3      ; dx^2+dy^2
        sqrtsd  xmm2, xmm2      ; sqrt
        
        movsd   xmm0, xmm2
        
        leave
        ret
