; Proc15 . Описать процедуру ShiftLeft3( A , B , C ), выполняющую левый циклический 
; сдвиг : значение A переходит в C , значение C — в B , значение B — в A
; ( A , B , C — вещественные параметры, являющиеся одновременно входными и выходными). 
; С помощью этой процедуры выполнить левый циклический сдвиг для двух
; данных наборов из трех чисел: ( A 1 , B 1 , C 1 ) и ( A 2 , B 2 , C 2 ).
;
; Вывод:
; 6, 5, 7
; 26, 15, 17

extern  printf
%macro  xchg_xmm 2
        pxor    %1, %2
        pxor    %2, %1
        pxor    %1, %2
%endmacro
section .data
        A1              dq      7.0
        B1              dq      6.0
        C1              dq      5.0
        
        A2              dq      17.0
        B2              dq      26.0
        C2              dq      15.0

        strFormat       db      "%g, %g, %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rdi, A1
        mov     rsi, B1
        mov     rdx, C1
        call    ShiftLeft3

        mov     rax, 3
        mov     rdi, strFormat
        movsd   xmm0, [A1]
        movsd   xmm1, [B1]
        movsd   xmm2, [C1]
        call    printf
        
        mov     rdi, A2
        mov     rsi, B2
        mov     rdx, C2
        call    ShiftLeft3

        mov     rax, 3
        mov     rdi, strFormat
        movsd   xmm0, [A2]
        movsd   xmm1, [B2]
        movsd   xmm2, [C2]
        call    printf
        
        leave
        ret

ShiftLeft3:
        ; ShiftLeft3
        ; Вход: rdi - адрес переменной A
        ;       rsi - адрес переменной B
        ;       rdx - адрес переменной C
        ; Выход: rdi, rsi, тот же адрес
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        ; a,b; a,c; b,c
        movsd   xmm0, [rdi]
        movsd   xmm1, [rsi]
        movsd   xmm2, [rdx]

        movsd   xmm3, xmm0
        movsd   xmm0, xmm1
        movsd   xmm1, xmm2
        movsd   xmm2, xmm3

        movsd   [rdi], xmm0
        movsd   [rsi], xmm1
        movsd   [rdx], xmm2
        leave
        ret
