; Series6 . Дано целое число N и набор из N положительных вещественных чисел.
; Вывести в том же порядке дробные части всех чисел из данного набора
; (как вещественные числа с нулевой целой частью), а также произведение
; всех дробных частей.
;
; Вывод:
;  0.1  0.2  0.3  0.4  0.5  0.6  0.7  0.8  0.9  0.1
; П=3.62881e-05

extern  printf
section .data
align 16
        series1         dd      1.1,2.2,3.3,4.4,5.5
                        dd      6.6,7.7,8.8,9.9,10.1
        N               equ     10
        series2         dd      0xDEADBEEF              ; заглушка с мусором
        strNumFmt       db      "%5.1f",0
        strFormat       db      10,"П=%g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, series1
        
        mov     rcx, N
        mov     rsi, series1
        mov     rax, 1
        cvtsi2ss xmm0, rax      ; произведение==1
loop_i:
        test    rcx, rcx
        jz      done
        movss   xmm2, [rsi]
        roundps xmm3, xmm2, 3   ; SSE4.1, режим 3 - округлить в меньшую сторону
        subss   xmm2, xmm3      ; дробная часть
        mulss   xmm0, xmm2
        ; сохранить перед выводом
        sub     rsp, 16
        movq    [rsp], xmm0
        push    rcx
        push    rsi
        
        mov     rax, 1
        mov     rdi, strNumFmt
        movss   xmm0, xmm2
        cvtss2sd xmm0, xmm0
        call    printf
        
        pop     rsi
        pop     rcx
        movq    xmm0, [rsp]
        add     rsp, 16
        
        dec     rcx
        add     rsi, 4
        jmp     loop_i
done:
        mov     rax, 1
        mov     rdi, strFormat
        cvtss2sd xmm0, xmm0     ; printf ожидает double, а не float
        cvtss2sd xmm1, xmm1
        call    printf
        
        leave
        ret
