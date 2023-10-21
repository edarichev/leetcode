; For16 ° . Дано вещественное число A и целое число N (> 0). Используя один
; цикл, вывести все целые степени числа A от 1 до N .
;
; Вывод:
; 2 ^ 1 = 2
; 2 ^ 2 = 4
;   ......
; 2 ^ 9 = 512
; 2 ^ 10 = 1024

extern  printf
section .data
        A               dq      2.0
        N               equ     10
        strFormat       db      "%g ^ %d = %g",10,0
        NL              db      10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, 1          ; счётчик
        mov     rbx, N
        cvtsi2sd xmm1, rcx      ; <- 1, начальное произведение
        movsd   xmm0, [A]
for_loop:
        cmp     rcx, rbx
        jg      done
        mulsd   xmm1, xmm0
        ; нужно сохранить всё в стеке
        sub     rsp, 16
        movsd   [rsp], xmm1
        sub     rsp, 16
        movsd   [rsp], xmm0
        push    rcx
        push    rbx
        mov     rax, 2          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, rcx
        call    printf
        ; теперь восстановить
        pop     rbx
        pop     rcx
        movsd   xmm0, [rsp]
        add     rsp, 16
        movsd   xmm1, [rsp]
        add     rsp, 16
        
        inc     rcx
        jmp     for_loop
done:
        leave
        ret
