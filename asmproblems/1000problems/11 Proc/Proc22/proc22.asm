; Proc22 . Описать функцию Calc( A , B , Op ) вещественного типа, выполняющую
; над ненулевыми вещественными числами A и B одну из арифметических
; операций и возвращающую ее результат. Вид операции определяется целым 
; параметром Op : 1 — вычитание, 2 — умножение, 3 — деление, 
; остальные значения — сложение. С помощью Calc выполнить для данных A
; и B операции, определяемые данными целыми N 1 , N 2 , N 3 .
;
; Вывод:
; 1
; 30
; 1.2
; 11

extern  printf

%macro  do_calc 3
        movsd   xmm0, %1
        movsd   xmm1, %2
        mov     rdi, %3
        call    Calc
        
        mov     rdi, strFormat
        mov     rax, 1
        call    printf
%endmacro

section .data
        A               dq      6.0
        B               dq      5.0
        strFormat       db      "%g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        do_calc [A], [B], 1
        do_calc [A], [B], 2
        do_calc [A], [B], 3
        do_calc [A], [B], 4
        
        leave
        ret

Calc:
        ; Вход: rdi - операция
        ;       xmm0 - A, xmm1 - B
        ; Выход: xmm0
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        cmp     rdi, 1
        je      .minus
        cmp     rdi, 2
        je      .multiply
        cmp     rdi, 3
        je      .divide
        ; plus
        addsd   xmm0, xmm1
        jmp     .exit
.minus:
        subsd   xmm0, xmm1
        jmp     .exit
.multiply:
        mulsd   xmm0, xmm1
        jmp     .exit
.divide:
        divsd   xmm0, xmm1
        jmp     .exit
.exit:
        leave
        ret
