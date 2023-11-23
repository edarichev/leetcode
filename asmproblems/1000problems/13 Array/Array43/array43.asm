; Array43. Дан целочисленный массив размера N, все элементы которого 
; упорядочены (по возрастанию или по убыванию). Найти количество различных
; элементов в данном массиве.
;
; Вывод:
; 6      (arr)
; 8      (arr1)

%include "../../utils.inc"

extern  printf
section .data
        R               equ     15
        N               equ     10
        arr             dq      1,2,2,2,3,4,5,5,6,6
        arr1            dq      9,8,7,6,5,4,4,3,3,1
        strFormat       db      "%ld",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 1          ; отсчёт с 1 по условию
        mov     rsi, arr
        mov     rax, qword [rsi]
        add     rsi, 8
        mov     rdx, N          ; счётчик, на каждом одинаковом элементе -1, если нет повторов, то в конце == N
loop_i:
        inc     rcx
        cmp     rcx, N
        jg      break_i
        mov     rbx, qword [rsi]
        add     rsi, 8
        
        cmp     rbx, rax
        jne     next
        dec     rdx             ; -1, это повтор
next:
        mov     rax, rbx        ; продвинуть - теперь текущий станет предыдущим
        jmp     loop_i
break_i:
        mov     rdi, strFormat
        mov     rsi, rdx
        call    printf
        
        leave
        ret
