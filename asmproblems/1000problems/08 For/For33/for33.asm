; For33 ° . Дано целое число N (> 1). Последовательность чисел Фибоначчи F K
; (целого типа) определяется следующим образом:27
; F 1 = 1,
; F 2 = 1,
; F K = F K–2 + F K–1 , K = 3, 4, ... .
; Вывести элементы F 1 , F 2 , ..., F N .
;
; Вывод:
; 1  1  2  3  5  8  13  21  34  55  89  144
extern  printf
section .data
        N               equ     10
        strFormat       db      "%d  ",0
        strFormatStart  db      "1  1  ",0
        NL              db      10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rax, 0
        mov     rdi, strFormatStart
        call    printf
        
        mov     rax, 1          ; F1=>k-2
        mov     rbx, 1          ; F2=>k-1
        mov     rcx, 1          ; счётчик
for_loop: ; можно условие выхода проверить в конце, но у нас имитация for - это предусловие и инкремент после действий
        cmp     rcx, N
        jg      exit
        
        mov     rsi, rax         ; след. == сумма двух предыдущих, используем RSI и как параметр printf
        add     rsi, rbx
        mov     rax, rbx        ; передвигаем последовательность
        mov     rbx, rsi
        
        push    rax
        push    rbx
        push    rcx
        mov     rax, 0
        mov     rdi, strFormat
        call    printf
        
        pop     rcx
        pop     rbx
        pop     rax
        inc     rcx
        
        jmp     for_loop
exit:
        mov     rax, 0
        mov     rdi, NL
        call    printf
        leave
        ret
