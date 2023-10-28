; While1 ° . Даны положительные числа A и B ( A > B ). На отрезке длины A размещено 
; максимально возможное количество отрезков длины B (без наложений). 
; Не используя операции умножения и деления, найти длину незанятой
; части отрезка A .
;
; Вывод:
; 2 (при 14 и 3: 3*4=12, 14-12=2)

extern  printf
section .data
        A               equ     14
        B               equ     3
        strFormat       db      "%d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; здесь нужно прибавлять от 0 до A число B и прерваться, когда сумма превысит A
        mov     rax, A
        mov     rbx, B
        mov     rdx, 0          ; сюда прибавим rbx==B
loop_i:
        add     rdx, rbx
        cmp     rdx, rax
        jg      done
        jmp     loop_i
done:
        cmp     rdx, rax
        jle     result
        sub     rdx, rbx
result:
        sub     rax, rdx
        mov     rsi, rax
        mov     rax, 0
        mov     rdi, strFormat
        call    printf
        leave
        ret
