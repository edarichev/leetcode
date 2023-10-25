; While12 ° . Дано целое число N (> 1). Вывести наибольшее из целых чисел K , для
; которых сумма 1 + 2 + ... + K будет меньше или равна N , и саму эту сумму.
;
; Вывод:
; N = 280, K = 7, S = 28

extern  printf
section .data
        N               equ     29
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
        jg      done
        inc     rdx
        jmp     loop_i
done:
        sub     rcx, rdx
        mov     rax, 0
        mov     rdi, strFormat
        mov     rsi, N
        ; rdx == K
        ; rcx == S
        call    printf
        leave
        ret
