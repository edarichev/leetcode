; Series2 . Даны десять вещественных чисел. Найти их произведение.
;
; Вывод:
; П=3.6288e+06 (==10!)

extern  printf
section .data
align 16
        series1         dd      1.0,2.0,3.0,4.0,5.0
                        dd      6.0,7.0,8.0,9.0,10.0
        series2         dd      0xDEADBEEF              ; заглушка с мусором
        strFormat       db      "П=%g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, series1
        
        mov     rcx, 10
        mov     rsi, series1
        mov     rax, 1
        cvtsi2ss xmm0, rax
loop_i:
        test    rcx, rcx
        jz      done
        mulss   xmm0, [rsi]
        dec     rcx
        add     rsi, 4
        jmp     loop_i
done:
        mov     rax, 1
        mov     rdi, strFormat
        cvtss2sd xmm0, xmm0     ; printf ожидает double, а не float
        call    printf
        
        leave
        ret
