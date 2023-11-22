; Array38. Дан массив размера N. Найти количество участков, на которых его элементы монотонно убывают.
;
; Вывод:
; 0     (arr)
; 1     (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      -3, 2, -5, 1, -20, 4, -99, 160, -321, 20
        arr1            dq      1,2,3,-4,5,6,7,-8,-9,10
        strFormat       db      "%ld",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; монотонно - значит не менее двух подряд в одну сторону
        mov     rcx, 0                  ; нумеруем с 0
        mov     rsi, arr1
        mov     rax, qword [rsi]        ; левый
        mov     rdx, 0                  ; признак: 0 - условие монотонности не выполняется, не 0 - выполняется, храним число точек в последовательности
        mov     rdi, 0                  ; ответ
loop_i:
        inc     rcx
        cmp     rcx, N
        jge     break_i
        add     rsi, 8
        mov     rbx, qword [rsi]
        cmp     rax, rbx
        jle     err
        inc     rdx                     ; признак: монотонность
        jmp     next
err:
        cmp     rdx, 2                  ; предыдущий участок рос? (не менее 2 точек)
        jl      set_zero
        inc     rdi                     ; +1 число участков
set_zero:
        mov     rdx, 0
next:
        jmp     loop_i
break_i:
        mov     rsi, rdi
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
