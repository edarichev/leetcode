; For38 . Дано целое число N (> 0). Найти сумму 1 N + 2 N–1 + ... + N 1 . 
; Чтобы избежать целочисленного переполнения, вычислять слагаемые этой суммы с
; помощью вещественной переменной и выводить результат как вещественное число.
;
; Вывод:
; Summ=65
; (при 1×1×1×1×1+2×2×2×2+3×3×3+4×4+5)
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

        pxor    xmm0, xmm0      ; итоговая сумма
        mov     rcx, N          ; идём с конца и до 1 - это степень
        mov     rax, 1
        cvtsi2sd xmm1, rax      ; <- 1.0, нужен для стартового значения каждого произведения
loop_n:
        test    rcx, rcx
        jz      done
        mov     rdx, N
        sub     rdx, rcx
        inc     rdx
        cvtsi2sd xmm2, rcx      ; xmm2 == текущий множитель, начинаем с N, с конца, например, 5
        movsd   xmm3, xmm1      ; xmm3 <- 1.0 из xmm1 == текущее произведение
        loop_i:
                test    rdx, rdx
                jz      break_loop_i
                mulsd   xmm3, xmm2      ; i^i
                dec     rdx
                jmp     loop_i
        break_loop_i:
        addsd   xmm0, xmm3
        dec     rcx
        jmp     loop_n
done:
        mov     rdi, strFormat
        mov     rax, 1
        ; xmm0 уже есть
        call    printf
        
        leave
        ret
