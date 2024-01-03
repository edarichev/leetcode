; Begin33 . Известно, что X кг конфет стоит A рублей. Определить, сколько стоит
; 1 кг и Y кг этих же конфет.
; Вывод:
; 1 kg = 50 R., Y kg = 125 R.
extern  printf
section .data
        X       dq      1.5
        A       dq      75.0
        Y       dq      2.5
        strFormat       db      "1 kg = %g R., Y kg = %g R.",10,0
section .bss
        KG      resq    1
        YR      resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; 1 KG
        movsd   xmm0, [A]
        movsd   xmm1, [X]
        divsd   xmm0, xmm1      ; A/X=1kg
        movsd   [KG], xmm0
        ; Y KG
        mulsd   xmm0, [Y]
        movsd   [YR], xmm0
        
        mov     rax, 1
        cvtsi2sd xmm0, rax
                
        ; выводим
        mov     rdi, strFormat
        movsd   xmm0, [KG]
        movsd   xmm1, [YR]
        mov     rax, 2          ; кол-во вещественных чисел
        call    printf
        
        leave
        ret
