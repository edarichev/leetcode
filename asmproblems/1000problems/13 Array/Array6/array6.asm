; Array6. Даны целые числа N (> 2), A и B. Сформировать и вывести целочисленный 
; массив размера N, первый элемент которого равен A, второй равен B, а
; каждый последующий элемент равен сумме всех предыдущих.
;
; Вывод:
; [3, 2, 5, 10, 20, 40, 80, 160, 320, 640]

%include "../../utils.inc"

extern  printf
section .data
        N       equ     10
        A       equ     3
        B       equ     2
section .bss
        arr     resq    N
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 2
        mov     rbx, A
        mov     rdx, B
        mov     rsi, arr
        mov     qword [rsi], rbx        ; #1
        add     rsi, 8
        mov     qword [rsi], rdx        ; #2
        add     rsi, 8
        mov     rax, rbx                ; в rax держим сумму
        add     rax, rdx
loop_i:
        cmp     rcx, N
        jg      exit
        mov     qword [rsi], rax
        add     rax, rax                ; по сути это удвоение последнего
        inc     rcx
        add     rsi, 8
        jmp     loop_i
exit:
        mov     rdi, arr
        mov     rsi, N
        call    PrintInt64Array
        
        leave
        ret
