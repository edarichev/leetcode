; For5 ° . Дано вещественное число — цена 1 кг конфет. Вывести стоимость 0.1,
; 0.2, ..., 1 кг конфет.
;
; Вывод:
; 0.1 кг стоят 1.265 р.
; 0.2 кг стоят 2.53 р.
; 0.3 кг стоят 3.795 р.
;     .......
; 1 кг стоят 12.65 р.


extern  printf
section .data
        P1KG            dq      12.65   ; р./кг
        Delta           dq      0.1     ; dp=0.1kg
        N               dq      1.0    ; до N кг
        strFormat       db      "%3.2f кг стоят %3.2f р.",10, 0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        pxor    xmm7, xmm7      ; <- 0
        addsd   xmm7, [Delta]
for_loop:
        movsd   xmm6, xmm7      ; сохранить текущее значение кг.
        movsd   xmm3, [N]
        cmplepd xmm7, xmm3
        movq    rax, xmm7
        test    rax, rax
        jz      break_loop
        ; вывод
        mov     rax, 2
        mov     rdi, strFormat
        movsd   xmm0, xmm6      ; кг.
        movsd   xmm1, xmm6      ; кг
        mulsd   xmm1, [P1KG]    ; кг*р/кг
        sub     rsp, 16
        movq    qword [rsp], xmm6
        call    printf
        movq    xmm0, qword [rsp]
        add     rsp, 16
        
        movsd   xmm7, xmm6      ; вернуть текущее значение кг.
        addsd   xmm7, [Delta]      ; увеличить кг. на 1
        jmp     for_loop
break_loop:
        leave
        ret
