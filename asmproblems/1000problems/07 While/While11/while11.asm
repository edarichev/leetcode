; While11 ° . Дано целое число N (> 1). Вывести наименьшее из целых чисел K ,
; для которых сумма 1 + 2 + ... + K будет больше или равна N , и саму эту
; сумму.
;
; Вывод:
; N = 30, K = 8, S = 36

extern  printf
section .data
        N               equ     30
        strFormat       db      "N = %d, K = %d, S = %d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rdx, 1          ; rdx==K
        xor     rcx, rcx        ; rcx == S
loop_i:
        add     rcx, rdx
        cmp     rcx, N
        jge     done
        inc     rdx
        jmp     loop_i
done:
        mov     rax, 0
        mov     rdi, strFormat
        mov     rsi, N
        ; rdx == K
        ; rcx == S
        call    printf
        leave
        ret
