; Array47o. Дан целочисленный массив размера N. Найти количество различных элементов в данном массиве.
;
; Вывод:
; 8      (arr)
; 9      (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      1,2,2,3,4,2,6,7,8,9
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
        mov     rsi, rdx
        call    printf
        
        leave
        ret
