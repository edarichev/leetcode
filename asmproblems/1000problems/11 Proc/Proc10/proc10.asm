; Proc10 . Описать процедуру Swap( X , Y ), меняющую содержимое переменных X
; и Y ( X и Y — вещественные параметры, являющиеся одновременно входными и выходными). 
; С ее помощью для данных переменных A , B , C , D 
; последовательно поменять содержимое следующих пар: A и B , C и D , B и C
; и вывести новые значения A , B , C , D .
;
; Вывод:
; // 1, 5 -> 5, 1
; // 6, 7 -> 7, 6
; // 1, 7 -> 7, 1
; 5, 7, 1, 6

extern  printf
%macro  call_Swap       2
        mov     rdi, %1
        mov     rsi, %2
        call    Swap
%endmacro
section .data
        A               dq      1
        B               dq      5
        C               dq      6
        D               dq      7
        strFormat       db      "%d, %d, %d, %d",10,0
section .bss
        A1              resq    1
        B1              resq    1
        C1              resq    1
        D1              resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rax, [A]
        mov     [A1], rax
        mov     rax, [B]
        mov     [B1], rax
        mov     rax, [C]
        mov     [C1], rax
        mov     rax, [D]
        mov     [D1], rax
        
        call_Swap    A1, B1
        call_Swap    C1, D1
        call_Swap    B1, C1
        
        xor     rax, rax
        mov     rdi, strFormat
        mov     rsi, [A1]
        mov     rdx, [B1]
        mov     rcx, [C1]
        mov     r8, [D1]
        call    printf
        
        leave
        ret

Swap:
        ; Swap
        ; Вход: rdi - адрес переменной X, int64
        ;       rsi - адрес переменной X, int64
        ; Выход: rdi, rsi, тот же адрес
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp

        mov     rax, [rdi]
        mov     rcx, [rsi]
        
        mov     [rdi], rcx
        mov     [rsi], rax
        
        leave
        ret
