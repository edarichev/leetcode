; While6 . Дано целое число N (> 0). Найти двойной факториал N :
; N !! = N ·( N –2)·( N –4)·...
; (последний сомножитель равен 2, если N — четное, и 1, если N — нечетное). 
; Чтобы избежать целочисленного переполнения, вычислять это произведение 
; с помощью вещественной переменной и вывести его как вещественное число.
;
; Вывод:
; 10!! = 3840
; 9!! = 945

extern  printf
section .data
        N               dq      2
        strFormat       db      "%d!! = %g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rbx, [N]
        cvtsi2sd xmm0, rbx      ; ==N
        movsd   xmm3, xmm0      ; это множитель, уменьшающийся на 2 каждый раз
        mov     rax, 2
        cvtsi2sd xmm2, rax      ; xmm2 <- 2.0, вычитаемое, т.к. вычитаем по 2.0
        
loop_i:
        sub     rbx, 2
        cmp     rbx, 1          ; достаточно до 1, т.к. X*1==X, лишний проход
        jle     done
        subsd   xmm3, xmm2      ; i-2.0
        mulsd   xmm0, xmm3
        jmp     loop_i
done:
        mov     rax, 1
        mov     rdi, strFormat
        mov     rsi, [N]
        ; xmm0 - факториал
        call    printf
        leave
        ret
