; For36 ° . Даны целые положительные числа N и K . Найти сумму
; 1^K + 2^K + ... + N^K .
; Чтобы избежать целочисленного переполнения, вычислять слагаемые этой
; суммы с помощью вещественной переменной и выводить результат как
; вещественное число.
;
; Вывод:
; Summ=220825
; (при 1+2×2×2×2×2+3×3×3×3×3+4×4×4×4×4+5×5×5×5×5+6×6×6×6×6+7×7×7×7×7+8×8×8×8×8+9×9×9×9×9+10×10×10×10×10)
extern  printf
section .data
        N               equ     10
        K               equ     5
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
        mov     rdx, 1          ; rdx: 1..k
        cvtsi2sd xmm1, rdx      ; степень числа i, здесь == 1, как и rdx
        cvtsi2sd xmm2, rcx
        loop_k:
                cmp     rdx, K
                jg      break_loop_k
                mulsd   xmm1, xmm2
                inc     rdx
                jmp     loop_k
        break_loop_k:
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
