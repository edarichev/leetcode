; Proc7 . Описать процедуру InvDigits( K ), меняющую порядок следования цифр
; целого положительного числа K на обратный ( K — параметр целого типа,
; являющийся одновременно входным и выходным). С помощью этой процедуры 
; поменять порядок следования цифр на обратный для каждого из
; пяти данных целых чисел.
;
; Вывод:
; 123 -> 321
; 2345 -> 5432
; 123456789 -> 987654321

extern  printf

%macro  work_number 1
        mov     rax, [%1]
        mov     [A1], rax
        mov     rdi, A1
        call    InvDigits
        
        xor     rax, rax
        mov     rdi, strFormat
        mov     rsi, [%1]
        mov     rdx, [A1]
        call    printf
%endmacro

section .data
        A               dq      123
        B               dq      2345
        C               dq      123456789
        strFormat       db      "%d -> %d",10,0
section .bss
        A1              resq    1       ; temp
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        work_number     A
        work_number     B
        work_number     C
        
        leave
        ret

InvDigits:
        ; InvDigits
        ; Вход: rdi - адрес переменной, int64
        ; Выход: rdi, тот же адрес
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        mov     rax, [rdi]
        mov     rbx, 10
        mov     rcx, 0
        .loop_i:
                test    rax, rax
                jz      .break_i
                cdq
                idiv    rbx
                imul    rcx, 10
                add     rcx, rdx
                jmp     .loop_i
        .break_i:
        mov     [rdi], rcx
        leave
        ret
