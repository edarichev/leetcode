; Array27. Дан массив ненулевых целых чисел размера N. Проверить, чередуются
; ли в нем положительные и отрицательные числа. Если чередуются, 
; то вывести 0, если нет, то вывести порядковый номер первого элемента, нарушающего закономерность.
;
; Вывод:
; 0      (arr)
; 6      (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      -3, 2, -5, 1, -20, 4, -99, 160, -321, 20
        arr1            dq      1,-2,3,-4,5,6,7,8,9,10
        fmt             db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rsi, arr
        mov     rax, [rsi]
        add     rsi, 8
        mov     rcx, 2          ; считаем с 1
        shr     rax, 63         ; старший бит - знаковый
        mov     r8, 0
loop_i:
        cmp     rcx, N
        jg      break_i
        mov     rbx, [rsi]
        shr     rbx, 63
        xor     rax, rbx        ; если биты одинаковы, то будет 0
        jnz     next            ; порядок соблюдён
        mov     r8, rcx
        jmp     break_i
next:
        mov     rax, rbx        ; меняем последний бит на противоположный, это так, если последовательность чередуется
        inc     rcx
        add     rsi, 8
        jmp     loop_i
break_i:
        mov     rdi, fmt
        mov     rsi, r8
        call    printf
        
        leave
        ret
