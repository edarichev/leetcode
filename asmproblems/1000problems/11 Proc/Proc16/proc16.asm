; Proc16 . Описать функцию Sign( X ) целого типа, возвращающую для вещественного числа X следующие значения:
; –1, если X < 0;
; 0, если X = 0;
; 1, если X > 0.
; С помощью этой функции найти значение выражения Sign( A ) + Sign( B ) для
; данных вещественных чисел A и B .
;
; Вывод:
; 7, -6 -> 0
; -7, -6 -> -2
; 7, 6 -> 2

extern  printf
%macro  xchg_xmm 2
        pxor    %1, %2
        pxor    %2, %1
        pxor    %1, %2
%endmacro
section .data
        A               dq      7.0
        B               dq      6.0
        strFormat       db      "%g, %g -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        xor     rbx, rbx        ; rbx сохраняется
        movsd   xmm0, [A]
        call    Sign
        add     rbx, rax
        
        movsd   xmm0, [B]
        call    Sign
        add     rbx, rax
        
        mov     rax, 2
        mov     rdi, strFormat
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        mov     rsi, rbx
        call    printf
        
        leave
        ret

Sign:
        ; Вход: xmm0 - переменная X
        ; Выход: rax: 0, 1, -1
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp

        movq    rax, xmm0
        test    rax, rax
        jz      .exit_sign      ; 0
        shr     rax, 63         ; в вещественном старший бит - знаковый
        test    rax, rax
        jnz     .set_negative
        mov     rax, 1
        jmp     .exit_sign
.set_negative:
        mov     rax, -1
.exit_sign:
        leave
        ret
