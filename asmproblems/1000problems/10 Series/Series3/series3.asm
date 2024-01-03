; Series3 . Даны десять вещественных чисел. Найти их среднее арифметическое.
;
; Вывод:
; A=5.5

extern  printf
section .data
align 16
        series1         dd      1.0,2.0,3.0,4.0,5.0
                        dd      6.0,7.0,8.0,9.0,10.0
        series2         dd      0xDEADBEEF              ; заглушка с мусором
        strFormat       db      "A=%g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, series1
        
        mov     rcx, 10
        cvtsi2ss xmm1, rcx
        mov     rsi, series1
        pxor    xmm0, xmm0      ; Summ==0
loop_i:
        test    rcx, rcx
        jz      done
        addss   xmm0, [rsi]
        dec     rcx
        add     rsi, 4
        jmp     loop_i
done:
        
        divss   xmm0, xmm1
        mov     rax, 1
        mov     rdi, strFormat
        cvtss2sd xmm0, xmm0     ; printf ожидает double, а не float
        call    printf
        
        leave
        ret
