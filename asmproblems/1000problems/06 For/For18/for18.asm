; For18 . Дано вещественное число A и целое число N (> 0). Используя один цикл,
; найти значение выражения
; 1 – A + A^2 – A^3 + ... + (–1)^N · A^N .
; Условный оператор не использовать.
;
; Вывод:
; -5 (при 1 - 2 + 2^2 - 2^3)

extern  printf
section .data
        A               dq      2.0
        N               equ     3
        strFormat       db      "Summ = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rax, 1
        cvtsi2sd xmm1, rax      ; число 1/-1
        ; чтобы не проверять степень 0, сразу занесём её в xmm0
        movsd   xmm0, xmm1      ; сумма, S=1
        mov     rax, 0x8000000000000000 ; для смены знака
        movq    xmm2, rax
        movsd   xmm3, xmm1     ; степень числа A, пока ^0 == 1
        movsd   xmm4, [A]      ; само число A, на него будем умножать xmm3
        mov     rcx, 1
for_loop:
        cmp     rcx, N
        jg      done
        ; поскольку начали со второго члена ряда, то сразу меняем знак у единичного множителя:
        pxor    xmm1, xmm2
        mulsd   xmm3, xmm4      ; ... * A, без знака
        movsd   xmm5, xmm3
        mulsd   xmm5, xmm1      ;  * (+/-1)
        addsd   xmm0, xmm5
        inc     rcx
        jmp     for_loop
done:
        mov     rax, 1
        mov     rdi, strFormat
        ; xmm0 уже есть - это результат
        call    printf
        leave
        ret
