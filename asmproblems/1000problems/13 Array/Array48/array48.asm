; Array48. Дан целочисленный массив размера N. Найти максимальное количество его одинаковых элементов.
;
; Вывод:
; 8      (arr)
; 1      (arr1)

%include "../../utils.inc"
; непонятно, что имеется в виду, полагаю, что это число всех, которые повторяются, т.е. N-число уникальных
extern  printf
section .data
        N               equ     10
        arr             dq      1,2,1,2,1,2,1,2,1,2
        arr1            dq      9,8,7,6,5,6,4,3,2,1
        strFormat       db      "%ld",10,0
section .bss
        ; надо как-то помечать найденные, например, хранить их в этом массиве
        distinct         resq    N
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, 1          ; отсчёт с 1 по условию
        mov     rsi, arr1
        mov     rdx, 0          ; кол-во различных == размер массива distinct
        mov     r9, 0           ; кол-во одинаковых
loop_i:
        cmp     rcx, N
        jg      break_i
        ; смотрим найденные
        mov     rdi, distinct
        mov     r8, rdx
        mov     rax, qword [rsi]
        loop_j:
                test    r8, r8
                jz      break_j
                cmp     qword [rdi], rax
                je      found_j
                dec     r8
                add     rdi, 8
                jmp     loop_j
        break_j:
                ; новое значение
                inc     rdx
                mov     qword [rdi], rax
        found_j:
        inc     rcx
        add     rsi, 8
        jmp     loop_i
break_i:
        mov     rdi, strFormat
        mov     rsi, N
        sub     rsi, rdx
        call    printf
        
        leave
        ret
