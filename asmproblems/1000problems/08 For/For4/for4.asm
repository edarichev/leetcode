; For4 . Дано вещественное число — цена 1 кг конфет. Вывести стоимость 1,
; 2, ..., 10 кг конфет.
;
; Вывод:
; 1 кг стоят 12.65 р.
; 2 кг стоят 25.3 р.
;        .....
; 10 кг стоят 126.5 р.

extern  printf
section .data
        P1KG            dq      12.65   ; р./кг
        N               dq      10.0    ; до N кг
        strFormat       db      "%g кг стоят %g р.",10, 0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        
        mov     rax, 1
        cvtsi2sd xmm7, rax      ; <- 1
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
        mov     rax, 1
        cvtsi2sd xmm8, rax      ; <- 1
        addsd   xmm7, xmm8      ; увеличить кг. на 1
        jmp     for_loop
break_loop:
        leave
        ret
