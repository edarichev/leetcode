; Array52. Дан массив A размера N. Сформировать новый массив B того же размера, 
; элементы которого определяются следующим образом:
;       2·A K , если A K < 5,
; B K =
;       A K /2 в противном случае.
;
; Вывод:
; [1, 2, 3, 4, 6, 5, 7, 8, 9, 10]
; [2, 4, 6, 8, 12, 2, 3, 4, 4, 5]

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        A               dq      1,2,3,4,6,5,7,8,9,10
section .bss
        B               resq    N
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rcx, 0          ; пусть сейчас с 0
        mov     rbx, A
        mov     r9, B
        mov     r8, 2           ; делитель
loop_i:
        cmp     rcx, N
        je      break_i
        mov     rax, qword [rbx]
        cmp     rcx, 5
        jge     greater5
        ; < 5
        imul    rax, 2
        jmp     next
greater5:
        cdq
        idiv    r8
next:
        mov     qword [r9], rax
        inc     rcx
        add     rbx, 8
        add     r9, 8
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
