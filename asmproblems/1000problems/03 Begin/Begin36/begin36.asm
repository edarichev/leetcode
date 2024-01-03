; Begin36 . Скорость первого автомобиля V 1 км/ч, второго — V 2 км/ч, расстояние
; между ними S км. Определить расстояние между ними через T часов, если
; автомобили удаляются друг от друга. Данное расстояние равно сумме начального 
; расстояния и общего пути, проделанного автомобилями; 
; общий путь = время · суммарная скорость.
; Вывод:
; ST = 205
extern  printf
section .data
        S       dq      10.0
        V1      dq      60.0
        V2      dq      70.0
        T       dq      1.5
        strFormat       db      "ST = %g",10,0
section .bss
        ST      resq    1       ; 10+(60+70)*1.5
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; суммарная скорость:
        movsd   xmm0, [V1]
        addsd   xmm0, [V2]
        mulsd   xmm0, [T]       ; насколько удалились за T
        addsd   xmm0, [S]       ; да ещё начальное расстояние
        movsd   [ST], xmm0
        
        ; выводим - уже в xmm0
        mov     rdi, strFormat
        mov     rax, 3          ; кол-во вещественных чисел
        call    printf
        
        leave
        ret
