; Array35. Дан массив размера N. Найти минимальный из его локальных максимумов (определение локального максимума дано в задании Array33).
;
; Вывод:
; 1     (arr)
; 3     (arr1)

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
        ; исключим из рассмотрения первый и последний элемент, и считаем максимумом только такое: /\
        ; выгоднее всего идти с конца
        mov     rcx, N+1                ; т.к. в цикле у нас rcx будет стоять на левом, чтобы не вычитать
        mov     rsi, arr + N * 8 - 8
        mov     rax, qword [rsi]        ; правый
        dec     rcx
        sub     rsi, 8
        mov     rbx, qword [rsi]        ; центральный
        mov     rdx, LONG_MAX           ; ответ
loop_i:
        dec     rcx
        cmp     rcx, 1                  ; это выход, т.к. от N+1
        jle     break_i                 
        sub     rsi, 8
        mov     rdi, qword [rsi]        ; левый
        ; проверим условия максимума
        cmp     rax, rbx                ; *\ : rax < rbx ?
        jge     next
        cmp     rdi, rbx                ; /* : rdi < rbx ?
        jge     next
        ; просто немного изменим решение задачи №33
        cmp     rbx, rdx                ; сравним с предыдущим найденным максимумом
        jge     next
        mov     rdx, rbx
next:
        mov     rax, rbx
        mov     rbx, rdi
        jmp     loop_i
break_i:
        mov     rdi, strFormat
        mov     rsi, rdx
        call    printf
        
        leave
        ret
