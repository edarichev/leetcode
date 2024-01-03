; Series1 ° . Даны десять вещественных чисел. Найти их сумму.
;
; Вывод:
; Sum=55

; в этой задаче я хочу использовать вещественные одинарной точности, выравнивание 
; и одновременное сложение нескольких чисел

extern  printf
section .data
align 16
        series1         dd      1.0,2.0,3.0,4.0,5.0
                        dd      6.0,7.0,8.0,9.0,10.0
        series2         dd      0xDEADBEEF              ; заглушка с мусором
        strFormat       db      "Sum=%g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, series1
        ; загрузим 4 числа по 4 байта в xmm0 (1,2,3,4)
        movdqa  xmm0, [rsi]     ; 1 | 2 | 3 | 4
        add     rsi, 16
        movdqa  xmm1, [rsi] ; числа 5-8
        add     rsi, 16
        ; суммируем содержимое частей регистра как 4 штуки float
        ; SSE3
        haddps  xmm0, xmm0      ; 3 | 7 | 3 | 7
        haddps  xmm0, xmm0      ; 10| 10| 10| 10
        haddps  xmm1, xmm1
        haddps  xmm1, xmm1      ; 26
        movss   xmm3, xmm0      ; 10
        addss   xmm3, xmm1      ; 10+26
        ; оставшаяся часть - 9 и 10
        movss   xmm0, [rsi]
        movss   xmm1, [rsi + 4]
        addss   xmm0, xmm1
        addss   xmm0, xmm3
        
        mov     rax, 1
        mov     rdi, strFormat
        cvtss2sd xmm0, xmm0     ; printf ожидает double, а не float
        call    printf
        
        leave
        ret
