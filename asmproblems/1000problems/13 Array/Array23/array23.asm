; Array23. Дан массив размера N и целые числа K и L (1 < K ≤ L ≤ N). Найти
; среднее арифметическое всех элементов массива, кроме элементов с номерами от K до L включительно.
;
; Вывод:
; 101        (==506/5)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        K               equ     3
        L               equ     7
        arr             dq      3, 2, 5, 1, 20, 4, 99, 160, 321, 20
        fmt             db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 1          ; отсчёт с 1 по условию книги
        mov     rsi, arr
        mov     rbx, 0          ; ответ
loop_i:
        cmp     rcx, N
        jg      exit_loop_i
        cmp     rcx, K
        jne     calc
        ; если попали на K, то:
        mov     rcx, L          ; переместим счётчик на L+1
        inc     rcx
        mov     rsi, arr + L * 8  ; указатель тоже переместить туда же (т.к. с 1, то 8L, а не 8L-8)
        jmp     loop_i
calc:
        add     rbx, [rsi]
        inc     rcx
        add     rsi, 8
        jmp     loop_i
exit_loop_i:
        mov     rax, rbx
        mov     rbx, L
        sub     rbx, K
        inc     rbx
        cdq
        idiv    rbx
        
        mov     rdi, fmt
        mov     rsi, rax
        call    printf
        
        leave
        ret
