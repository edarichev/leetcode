;Begin34 . Известно, что X кг шоколадных конфет стоит A рублей, а Y кг ирисок
; стоит B рублей. Определить, сколько стоит 1 кг шоколадных конфет, 1 кг
; ирисок, а также во сколько раз шоколадные конфеты дороже ирисок.
; Вывод:
; 1 kg Pralinen = 50 R., 1 kg Toffee = 10 R, P/T = 5
extern  printf
section .data
        X       dq      1.5
        A       dq      75.0
        Y       dq      2.5
        B       dq      25.0
        strFormat       db      "1 kg Pralinen = %g R., 1 kg Toffee = %g R, P/T = %g",10,0
section .bss
        KGP     resq    1
        KGT     resq    1
        VPT     resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; 1 KG Pralinen (шоколадные)
        movsd   xmm0, [A]
        movsd   xmm1, [X]
        divsd   xmm0, xmm1      ; A/X=1kg
        movsd   [KGP], xmm0
        ; 1 KG Toffee (ириски)
        movsd   xmm2, [B]
        movsd   xmm1, [Y]
        divsd   xmm2, xmm1      ; B/Y=1kg
        movsd   [KGT], xmm2
        ; Verhältnis (соотношение) Pralinen/Toffee
        divsd   xmm0, xmm2
        movsd   [VPT], xmm0
        
        mov     rax, 1
        cvtsi2sd xmm0, rax
                
        ; выводим
        mov     rdi, strFormat
        movsd   xmm0, [KGP]
        movsd   xmm1, [KGT]
        movsd   xmm2, [VPT]
        mov     rax, 3          ; кол-во вещественных чисел
        call    printf
        
        leave
        ret
