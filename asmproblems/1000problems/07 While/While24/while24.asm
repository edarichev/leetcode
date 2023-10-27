; While24 . Дано целое число N (> 1). Последовательность чисел Фибоначчи F K
; определяется следующим образом:
; F 1 = 1,
; F 2 = 1,
; F K = F K–2 + F K–1 , K = 3, 4, ... .
; Проверить, является ли число N числом Фибоначчи. Если является, то вывести True, если нет — вывести False.
;
; Вывод:
; False (N=9)
; True (N=8; => 1, 1, 2, 3, 5, 8, ...)

extern  printf
section .data
        N               equ     9
        strTrue         db      "True",10,0
        strFalse        db      "False",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rdi, strFalse
        mov     rax, N
        cmp     rax, 1
        je      labelTrue
        
        mov     rdx, 1
        mov     rsi, 1
loop_i:
        mov     rcx, rdx
        add     rcx, rsi
        cmp     rcx, N
        jg      done
        je      labelTrue
        mov     rdx, rsi
        mov     rsi, rcx
        jmp     loop_i
labelTrue:
        mov     rdi, strTrue
done:
        xor     rax, rax
        call    printf
        leave
        ret
