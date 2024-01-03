; Proc32 . Описать функцию DegToRad( D ) вещественного типа, находящую 
; величину угла в радианах, если дана его величина D в градусах 
; ( D — вещественное число, 0 < D < 360). Воспользоваться следующим соотношением:
; 180° = π радианов. В качестве значения π использовать 3.14. С помощью
; функции DegToRad перевести из градусов в радианы пять данных углов.
;
; Вывод:
; 25° = 0.436111 рад.
; 45° = 0.785 рад.
; 90° = 1.57 рад.
; 120° = 2.09333 рад.
; 180° = 3.14 рад.

extern  printf

section .data
        PI              dq      3.14
        series1         dq      25.0, 45.0, 90.0, 120.0, 180.0
        End             dq      $
        N               equ     5
        strFormat       db      "%g° = %g рад.",10,0
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
        call    DegToRad
        
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

DegToRad:
        ; Вход: 
        ;       xmm0 - D
        ; Выход: xmm0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp

        mov     rax, 180
        cvtsi2sd xmm1, rax
        mulsd   xmm0, [PI]
        divsd   xmm0, xmm1
.exit:
        
        leave
        ret
