; For14 . Дано целое число N (> 0). Найти квадрат данного числа, используя для
; его вычисления следующую формулу:
; N^2 = 1 + 3 + 5 + ... + (2· N – 1).
; После добавления к сумме каждого слагаемого выводить текущее значение
; суммы (в результате будут выведены квадраты всех целых чисел от 1
; до N ).
;
; Вывод:
;    1   4   9  16  25  36  49  64  81 100

extern  printf
section .data
        A               dq      1
        Step            dq      2
        N               equ     10
        strFormat       db      "%4d",0
        NL              db      10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, 1          ; счётчик
        mov     rbx, N
        imul    rbx, 2          ; верхний предел для счётчика 2N
        mov     rax, 0          ; сумма
for_loop:
        cmp     rcx, rbx
        jg      done
        add     rax, rcx        ; новая сумма
        mov     rdi, strFormat
        mov     rsi, rax
        push    rcx             ; сохраним, т.к. затирается
        push    rax
        mov     rax, 0          ; кол-во вещественных
        call    printf
        pop     rax
        pop     rcx
        inc     rcx
        inc     rcx
        jmp     for_loop
done:
        mov     rdi, NL
        call    printf
        leave
        ret
