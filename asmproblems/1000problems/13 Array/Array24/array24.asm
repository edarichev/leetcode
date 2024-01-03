; Array24. Дан целочисленный массив размера N, не содержащий одинаковых
; чисел. Проверить, образуют ли его элементы арифметическую прогрессию
; (см. задание Array3). Если образуют, то вывести разность прогрессии, если
; нет — вывести 0.
;
; Вывод:
; 1     (arr1)
; 2     (arr2)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      3, 2, 5, 1, 20, 4, 99, 160, 321, 20
        arr1            dq      1,2,3,4,5,6,7,8,9,10
        arr2            dq      2,4,6,8,10,12,14,16,18,20
        fmt             db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rsi, arr
        ; A, A + D, A + 2·D, A + 3·D, ... .
        mov     rbx, [rsi]
        add     rsi, 8
        mov     r9, rbx         ; первый член
        
        mov     rax, [rsi]
        add     rsi, 8
        mov     rdx, rax
        sub     rdx, rbx        ; разница двух членов == D, её наращиваем на каждом проходе ровно на D
        mov     r8, rdx         ; первоначальная - это разность прогрессии
        ; может быть 2 члена, тогда это последовательность, и ответ == их разности
        mov     rcx, N
        sub     rcx, 2          ; 2 просмотрено
loop_i:
        test    rcx, rcx
        jz      break_i
        add     rdx, r8         ; новая разница, == k*D
        mov     rax, [rsi]      ; новый член
        sub     rax, rdx        ; Ak - D*k => должно быть равно A1
        cmp     rax, r9
        jne     error
        
        dec     rcx
        add     rsi, 8
        jmp     loop_i
error:
        mov     r8, 0
break_i:
        mov     rdi, fmt
        mov     rsi, r8
        call    printf
        
        leave
        ret
