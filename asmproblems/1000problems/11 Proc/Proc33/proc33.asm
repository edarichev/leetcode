; Proc33 . Описать функцию RadToDeg( R ) вещественного типа, находящую 
; величину угла в градусах, если дана его величина R в радианах 
; ( R — вещественное число, 0 < R < 2· π ). Воспользоваться следующим соотношением:
; 180° = π радианов. В качестве значения π использовать 3.14. С помощью
; функции RadToDeg перевести из радианов в градусы пять данных углов.
;
; Вывод:
; 0.43 рад. = 24.6497°
; 0.785 рад. = 45°
; 1.57 рад. = 90°
; 2.09333 рад. = 120°
; 3.14 рад. = 180°

extern  printf

section .data
        PI              dq      3.14
        series1         dq      0.43, 0.785, 1.57, 2.09333, 3.14
        End             dq      $
        N               equ     5
        strFormat       db      "%g рад. = %g°",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, series1
        and     rsp, 0xfffffffffffffff0
loop_i:
        cmp     rsi, End
        jge     break_i
        
        push    rsi
        sub     rsp, 8
        
        movsd   xmm0, qword [rsi]
        call    RadToDeg
        
        mov     rdi, strFormat
        ; xmm0 - в результате
        movsd   xmm1, xmm0              ; обмен, т.к. надо по формату
        movsd   xmm0, qword [rsi]
        call    printf
        
        add     rsp, 8
        pop     rsi
        add     rsi, 8
        jmp     loop_i
break_i:
        leave
        ret

RadToDeg:
        ; Вход: 
        ;       xmm0 - D
        ; Выход: xmm0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp

        mov     rax, 180
        cvtsi2sd xmm1, rax
        divsd   xmm0, [PI]
        mulsd   xmm0, xmm1
.exit:
        
        leave
        ret
