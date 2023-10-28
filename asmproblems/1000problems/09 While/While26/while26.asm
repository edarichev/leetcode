; While26 . Дано целое число N (> 1), являющееся числом Фибоначчи: N = F K 
; (определение чисел Фибоначчи дано в задании While24). Найти целые числа
; F K–1 и F K+1 — предыдущее и последующее числа Фибоначчи.
;
; Вывод:
; 5, N=8, 13

extern  printf
section .data
        N               equ     8
        strFormat       db      "%d, N=%d, %d",10,0
        strError        db      "%d is not a Fibonacci number",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rsi, 1
        mov     rdx, 1
        
        cmp     rdx, N
        jge     labelError
loop_i:
        mov     rbx, rsi
        add     rbx, rdx
        cmp     rbx, N
        jg      labelError
        je      done
        mov     rsi, rdx
        mov     rdx, rbx
        jmp     loop_i
done:
        ; здесь в rdx предыдущее, rbx == N
        xor     rax, rax
        mov     rdi, strFormat
        mov     rsi, rdx
        mov     rcx, N
        add     rcx, rdx
        mov     rdx, N
        call    printf
        leave
        ret
labelError:
        xor     rax, rax
        mov     rdi, strError
        mov     rsi, N
        call    printf
        leave
        ret
