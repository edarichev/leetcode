; While2 . Даны положительные числа A и B ( A > B ). На отрезке длины A
; размещено максимально возможное количество отрезков длины B (без наложений).
; Не используя операции умножения и деления, найти количество отрезков B ,
; размещенных на отрезке A .
;
; Вывод:
; 4 (при 14 и 3)

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
        mov     rcx, 0          ; кол-во отрезков
        mov     rdx, 0          ; сюда прибавим rbx==B
loop_i:
        add     rdx, rbx
        cmp     rdx, rax
        jg      done
        inc     rcx
        jmp     loop_i
done:
        mov     rax, 0
        mov     rdi, strFormat
        mov     rsi, rcx
        call    printf
        leave
        ret
