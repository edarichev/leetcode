; For37 . Дано целое число N (> 0). Найти сумму 1^1 + 2^2 + ... + N^N . 
; Чтобы избежать целочисленного переполнения, вычислять слагаемые этой суммы с
; помощью вещественной переменной и выводить результат как вещественное число.
;
; Вывод:
; Summ=3413
; (при 1+2×2+3×3×3+4×4×4×4+5×5×5×5×5)
extern  printf
section .data
        N               equ     5
        strFormat       db      "Summ=%g",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 1          ; rcx: 1..n
        pxor    xmm0, xmm0      ; общая сумма
loop_n:
        cmp     rcx, N
        jg      done
        mov     rdx, 1
        cvtsi2sd xmm1, rdx      ; <- 1.0, текущее произведение
        cvtsi2sd xmm2, rcx      ; <- множитель == rcx
        loop_i:
                cmp     rdx, rcx
                jg      break_loop_i
                mulsd   xmm1, xmm2
                inc     rdx
                jmp     loop_i
        break_loop_i:
        addsd   xmm0, xmm1
        inc     rcx
        jmp     loop_n
done:
        mov     rdi, strFormat
        mov     rax, 1
        ; xmm0 уже есть
        call    printf
        
        leave
        ret
