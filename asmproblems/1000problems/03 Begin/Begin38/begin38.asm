; Begin38 . Решить линейное уравнение A·x + B = 0, заданное своими коэффициентами A и B (коэффициент A не равен 0).
; Вывод:
; x = -6
extern  printf
section .data
        A       dq      10.0
        B       dq      60.0
        strFormat       db      "x = %g",10,0
section .bss
        x       resq    1       ;
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; x = -B/A
        movsd   xmm1, [B]
        pxor    xmm0, xmm0      ; 0
        subsd   xmm0, xmm1      ; xmm1 <- -xmm0
        divsd   xmm0, [A]
        movsd   [x], xmm0
        
        ; выводим
        mov     rdi, strFormat
        mov     rax, 1          ; кол-во вещественных чисел
        movsd   xmm0, [x]       ; хотя оно уже в xmm0
        call    printf
        
        leave
        ret
