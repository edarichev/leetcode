; Array49. Дан целочисленный массив размера N. Если он является перестановкой, 
; то есть содержит все числа от 1 до N, то вывести 0; в противном случае вывести номер первого недопустимого элемента.
;
; Вывод:
; 3      (arr)
; 0      (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      1,2,1,2,1,2,1,2,1,2
        arr1            dq      9,8,7,6,5,4,3,2,1,10
        strFormat       db      "%ld",10,0
section .bss
        ; это значит, что число не должно быть меньше 1 и больше N,
        ; при этом числа не должны повторяться
        ; надо как-то помечать найденные, например, хранить их в этом массиве
        distinct         resq    N
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, 1          ; отсчёт с 1 по условию
        mov     rsi, arr
        mov     rdx, 0          ; кол-во различных == размер массива distinct
        mov     r9, 0           ; ответ
loop_i:
        cmp     rcx, N
        jg      break_i
        ; смотрим найденные
        mov     rdi, distinct
        mov     r8, rdx
        mov     rax, qword [rsi]
        cmp     rax, 1
        jl      found_j
        cmp     rax, N
        jg      found_j
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
        inc     rcx
        add     rsi, 8
        jmp     loop_i
found_j:
        mov     r9, rcx
        jmp     write
break_i:

write:
        mov     rdi, strFormat
        mov     rsi, r9
        call    printf
        
        leave
        ret
