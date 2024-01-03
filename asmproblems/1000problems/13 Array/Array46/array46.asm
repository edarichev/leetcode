; Array46. Дано число R и массив размера N. Найти два различных элемента 
; массива, сумма которых наиболее близка к числу R, и вывести эти элементы в
; порядке возрастания их индексов (определение наиболее близких чисел дано в задании Array40).
;
; Вывод:
; 3,5      (arr)
; 1,4      (arr1)

%include "../../utils.inc"

extern  printf
section .data
        R               equ     15
        N               equ     10
        arr             dq      1,2,11,3,4,2,6,7,8,9
        arr1            dq      9,8,7,6,5,6,4,3,2,1
        strFormat       db      "%ld, %ld",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; поскольку массив может быть не упорядочен, то будет вложенный цикл
        mov     rcx, 1          ; отсчёт с 1 по условию
        mov     rsi, arr
loop_i:
        cmp     rcx, N-1
        jg      break_i
        mov     rax, qword [rsi]
        
        mov     rdi, rsi
        mov     rdx, rcx
        mov     r8, -1
        mov     r9, -1
        mov     r10, LONG_MAX           ; текущая минимальная разница
        loop_j:
                inc     rdx
                add     rdi, 8
                cmp     rdx, N
                jg      break_j
                mov     rbx, qword [rdi]
                mov     r11, rax
                add     r11, rbx
                cmp     r11, R
                jne     check_diff
                ; равны, можно сразу закончить
                mov     r8, rax
                mov     r9, rbx
                jmp     break_i
        check_diff:
                sub     r11, R
                mov     r12, r11
                neg     r11
                cmovl   r11, r12
                cmp     r10, r11
                jge     loop_j
                mov     r8, rax
                mov     r9, rbx
                mov     r10, r11
                jmp     loop_j
        break_j:
next:
        inc     rcx
        add     rsi, 8
        jmp     loop_i
break_i:
        mov     rdi, strFormat
        mov     rsi, rcx
        ; rdx - это второй индекс, уже есть
        call    printf
        
        leave
        ret
