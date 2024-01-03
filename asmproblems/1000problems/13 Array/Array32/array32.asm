; Array32. Дан массив размера N. Найти номер его первого локального минимума 
; (локальный минимум — это элемент, который меньше любого из своих соседей).
;
; Вывод:
; 3     (arr)
; 2     (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      -3, 2, -5, 1, -20, 4, -99, 160, -321, 20
        arr1            dq      1,-2,3,-4,5,6,7,8,9,10
        strFormat       db      "%ld",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; массив нумеруем с 1 по условию
        mov     rcx, 0                  ; начнём с 0, чтобы не делать DEC, т.к. в цикле мы выйдем на следующий элемент
                                        ; если бы нумеровали с 0, то тут поставили бы -1
        mov     rsi, arr1
        mov     rax, qword [rsi]        ; левый
        add     rsi, 8
        inc     rcx
        mov     rbx, qword [rsi]        ; центральный
        mov     rdx, 0                  ; ответ
loop_i:
        inc     rcx
        add     rsi, 8
        cmp     rcx, N
        jge     break_i
        mov     rdi, qword [rsi]        ; правый
        cmp     rax, rbx                ; проверим условия минимума: rax > rbx && rbx < rdi
        jl      next
        cmp     rbx, rdi
        jg      next
        mov     rdx, rcx                ; текущий счётчик (он у нас с 0, поэтому верное значение)
        jmp     break_i
next:
        mov     rax, rbx                ; смещаем два предыдущих значения
        mov     rbx, rdi
        jmp     loop_i
break_i:
        mov     rdi, strFormat
        mov     rsi, rdx
        call    printf
        
        leave
        ret
