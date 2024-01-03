; While27 . Дано целое число N (> 1), являющееся числом Фибоначчи: N = F K 
; (определение чисел Фибоначчи дано в задании While24). Найти целое число K
; — порядковый номер числа Фибоначчи N .
;
; Вывод:
; N=8, K=6 (1,1,2,3,5,8)

extern  printf
section .data
        N               equ     8       
        strFormat       db      "N=%d, K=%d",10,0
        strError        db      "%d is not a Fibonacci number",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rax, 3          ; #2
        mov     rsi, 1          ; #1
        mov     rdx, 1          ; #2
        
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
        inc     rax
        jmp     loop_i
done:
        mov     rdi, strFormat
        mov     rsi, N
        mov     rdx, rax
        xor     rax, rax
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
