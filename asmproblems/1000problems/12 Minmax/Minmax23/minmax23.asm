; Minmax23. Дано целое число N (> 3) и набор из N чисел. Найти три наибольших 
; элемента из данного набора и вывести эти элементы в порядке убывания их значений.
;
; Вывод:
; 8, 5, 4

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      -1,2,3,4,5,-1,8,2,8,-1
        N               equ     10
        strFormat       db      "%ld, %ld, %ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     r10, LONG_MIN   ; максимальный1
        mov     r9, LONG_MIN    ; максимальный2
        mov     r8, LONG_MIN    ; максимальный3
loop_i:
        ; проще всего имитировать очередь: в r10 заносим новый максимум, а в r8 | r9 передвигаем предыдущий максимум
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        ; максимальный1
        cmp     rax, r10
        jle     next
        ; а в меньшие заносим предыдущее значение
        mov     r8, r9
        mov     r9, r10
        mov     r10, rax
        jmp     next
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        mov     rsi, r10
        mov     rdx, r9
        mov     rcx, r8
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
