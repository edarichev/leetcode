; While5 . Дано целое число N (> 0), являющееся некоторой степенью числа 2:
; N = 2^K . Найти целое число K — показатель этой степени.
;
; Вывод:
; 1024 = 2^10

extern  printf
section .data
        N               equ     1024
        strFormat       db      "%d = 2^%d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rax, N
        xor     rdx, rdx        ; ==K, его ищем
loop_i:
        shr     rax, 1          ; поскольку 2(10) == 10b, то сначала нужно сделать сдвиг и только потом проверять
        test    rax, rax
        jz      done            ; как  только закончатся единичные биты, степень найдена
        inc     rdx
        jmp     loop_i
done:
        mov     rax, 0
        mov     rdi, strFormat
        mov     rsi, N

        call    printf
        leave
        ret
