; Proc11 . Описать процедуру Minmax( X , Y ), записывающую в переменную X 
; минимальное из значений X и Y , а в переменную Y — максимальное из этих
; значений ( X и Y — вещественные параметры, являющиеся одновременно
; входными и выходными). Используя четыре вызова этой процедуры, найти
; минимальное и максимальное из данных чисел A , B , C , D .
;
; Вывод:
; 4, 5, 6, 7 (Min=4, Max=7)

extern  printf
section .data
        A               dq      7.0
        B               dq      6.0
        C               dq      5.0
        D               dq      4.0
        strFormat       db      "%g, %g, %g, %g (Min=%g, Max=%g)",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; судя по всему имеется в виду передача по ссылке с обменом
                                ; 7 6 5 4
        mov     rdi, A
        mov     rsi, B
        call    Minmax          ; 6 7 5 4
        
        mov     rdi, C
        mov     rsi, D
        call    Minmax          ; 6 7 4 5
        
        mov     rdi, A
        mov     rsi, C
        call    Minmax          ; 4 7 6 5
        
        mov     rdi, B
        mov     rsi, D
        call    Minmax          ; 4 5 6 7

        mov     rax, 4
        mov     rdi, strFormat
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        movsd   xmm2, [C]
        movsd   xmm3, [D]
        movsd   xmm4, [A]
        movsd   xmm5, [D]
        call    printf
        
        leave
        ret

Minmax:
        ; Minmax
        ; Вход: rdi - адрес переменной X
        ;       rsi - адрес переменной Y
        ; Выход: rdi, rsi, тот же адрес
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp

        movsd   xmm0, [rdi]
        movsd   xmm1, [rsi]
        
        movq    xmm2, xmm0
        cmplepd xmm2, xmm1
        movq    rax, xmm2
        test    rax, rax
        jnz     .exit           ; ничего не делать
        ; иначе поменять местами
        movsd   [rdi], xmm1
        movsd   [rsi], xmm0
.exit:
        leave
        ret
