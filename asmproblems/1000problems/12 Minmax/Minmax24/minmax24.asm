; Minmax24. Дано целое число N (> 1) и набор из N чисел. Найти максимальную
; сумму двух соседних чисел из данного набора.
;
; Вывод:
; 10

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      -1,2,3,4,5,-1,8,2,8,-1
        N               equ     10
        strFormat       db      "%ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     r10, LONG_MIN           ; максимальная сумма
        mov     rdx, qword [rsi]        ; предыдущий элемент
        inc     rcx
        add     rsi, 8
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        mov     rbx, rax
        add     rbx, rdx
        cmp     rbx, r10
        jle     next
        mov     r10, rbx                ; новая сумма
next:
        mov     rdx, rax                ; меняем предыдущий
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        mov     rsi, r10
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
