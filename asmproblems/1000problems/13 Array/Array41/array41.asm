; Array41. Дан массив размера N. Найти два соседних элемента, сумма которых
; максимальна, и вывести эти элементы в порядке возрастания их индексов.
;
; Вывод:
; -99, 61       (arr)
; 6,7           (arr1)

%include "../../utils.inc"

extern  printf
section .data
        R               equ     15
        N               equ     10
        arr             dq      -3, 2, -5, 1, -20, 4, -99, 160, -321, 20
        arr1            dq      1,2,3,-4,5,6,7,-8,-9,10
        strFormat       db      "%ld, %ld",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 1          ; отсчёт с 1 по условию
        mov     rsi, arr
        mov     rax, qword [rsi]
        add     rsi, 8

        mov     r8, -1          ; первый элемент в паре
        mov     r9, -1          ; второй элемент в паре
        mov     r10, LONG_MIN   ; максимальная сумма
loop_i:
        inc     rcx
        cmp     rcx, N
        jg      break_i
        mov     rbx, qword [rsi]
        add     rsi, 8
        mov     rdx, rax
        add     rdx, rbx
        cmp     rdx, r10
        jle     next
        ; сумма больше предыдущей
        mov     r10, rdx
        mov     r8, rax
        mov     r9, rbx
next:
        mov     rax, rbx        ; продвинуть - теперь текущий станет предыдущим
        jmp     loop_i
break_i:
        mov     rdi, strFormat
        mov     rsi, r8
        mov     rdx, r9
        call    printf
        
        leave
        ret
