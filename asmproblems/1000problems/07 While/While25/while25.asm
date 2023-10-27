; While25 . Дано целое число N (> 1). Найти первое число Фибоначчи, большее N .
; (определение чисел Фибоначчи дано в задании While24).
;
; Вывод:
; 13 (N=9)

extern  printf
section .data
        N               equ     8
        strFormat       db      "%d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rdx, 1
        mov     rsi, 1
loop_i:
        mov     rcx, rdx
        add     rcx, rsi
        cmp     rcx, N
        jg      done
        mov     rdx, rsi
        mov     rsi, rcx
        jmp     loop_i
done:
        xor     rax, rax
        mov     rdi, strFormat
        mov     rsi, rcx
        call    printf
        leave
        ret
