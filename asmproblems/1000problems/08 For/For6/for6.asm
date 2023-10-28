; For6 . Дано вещественное число — цена 1 кг конфет. Вывести стоимость 1.2,
; 1.4, ..., 2 кг конфет.
;
; Вывод:
; 1.20 кг стоят 15.18 р.
; 1.40 кг стоят 17.71 р.
; 1.60 кг стоят 20.24 р.
; 1.80 кг стоят 22.77 р.
; 2.00 кг стоят 25.30 р.

extern  printf
section .data
        P1KG            dq      12.65   ; р./кг
        StartWeight     dq      1.0     ; начальная масса
        Delta           dq      0.2     ; dp=0.1kg
        N               dq      2.0     ; до N кг
        strFormat       db      "%3.2f кг стоят %3.2f р.",10, 0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm7, [StartWeight]
        addsd   xmm7, [Delta]
for_loop:
        movsd   xmm6, xmm7      ; сохранить текущее значение кг., т.к. при проверке регистр затирается
        movsd   xmm3, [N]
        cmplepd xmm7, xmm3
        movq    rax, xmm7
        test    rax, rax
        jz      break_loop
        ; вывод
        mov     rax, 2          ; 2 вещественных
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
        addsd   xmm7, [Delta]   ; увеличить кг. на шаг
        jmp     for_loop
break_loop:
        leave
        ret
