; For19 ° . Дано целое число N (> 0). Найти произведение
; N ! = 1·2·...· N
; ( N–факториал ). Чтобы избежать целочисленного переполнения, вычислять 
; это произведение с помощью вещественной переменной и вывести
; его как вещественное число.
;
; Вывод:
; 10! =              3628800

extern  printf
section .data
        N               equ     10
        strFormat       db      "%d! = %20.0f",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rax, 1
        cvtsi2sd xmm0, rax
        mov     rcx, 1
        mov     rbx, N
for_loop:
        cmp     rcx, rbx
        jg      done
        cvtsi2sd xmm1, rcx
        mulsd   xmm0, xmm1
        inc     rcx
        jmp     for_loop
done:
        mov     rax, 1
        mov     rdi, strFormat
        mov     rsi, N
        ; xmm0 уже есть - это результат
        call    printf
        leave
        ret
