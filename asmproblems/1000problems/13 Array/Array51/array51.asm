; Array51. Даны массивы A и B одинакового размера N. Поменять местами их 
; содержимое и вывести вначале элементы преобразованного массива A, 
; а затем — элементы преобразованного массива B.
;
; Вывод:
; [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
; [1, 2, 3, 4, 6, 5, 7, 8, 9, 10]

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        A               dq      1,2,3,4,6,5,7,8,9,10
        B               dq      9,8,7,6,5,4,3,2,1,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rcx, 0
        mov     rbx, A
        mov     rdx, B
loop_i:
        cmp     rcx, N
        je      break_i
        mov     rax, qword [rbx]
        mov     r8, qword [rdx]
        mov     qword [rbx], r8
        mov     qword [rdx], rax
        inc     rcx
        add     rbx, 8
        add     rdx, 8
        jmp     loop_i
break_i:
write:
        mov     rdi, A
        mov     rsi, N
        call    PrintInt64Array
        
        mov     rdi, B
        mov     rsi, N
        call    PrintInt64Array

        leave
        ret
