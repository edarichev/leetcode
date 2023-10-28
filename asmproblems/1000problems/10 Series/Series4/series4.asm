; Series4 . Дано целое число N и набор из N вещественных чисел. Вывести сумму
; и произведение чисел из данного набора.
;
; Вывод:
; Summ=55, П=3.6288e+06

extern  printf
section .data
align 16
        series1         dd      1.0,2.0,3.0,4.0,5.0
                        dd      6.0,7.0,8.0,9.0,10.0
        N               equ     10
        series2         dd      0xDEADBEEF              ; заглушка с мусором
        strFormat       db      "Summ=%g, П=%g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, series1
        
        mov     rcx, N
        cvtsi2ss xmm1, rcx
        mov     rsi, series1
        pxor    xmm0, xmm0      ; Summ==0
        mov     rax, 1
        cvtsi2ss xmm1, rax      ; произведение==1
loop_i:
        test    rcx, rcx
        jz      done
        movss   xmm2, [rsi]
        addss   xmm0, xmm2
        mulss   xmm1, xmm2
        dec     rcx
        add     rsi, 4
        jmp     loop_i
done:
        mov     rax, 2
        mov     rdi, strFormat
        cvtss2sd xmm0, xmm0     ; printf ожидает double, а не float
        cvtss2sd xmm1, xmm1
        call    printf
        
        leave
        ret
