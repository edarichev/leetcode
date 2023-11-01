; Series22 . Дано целое число N (> 1) и набор из N вещественных чисел. Если
; данный набор образует убывающую последовательность, то вывести 0;
; в противном случае вывести номер первого числа, нарушающего
; закономерность.
;
; Вывод:
; 5

extern  printf
section .data
        series1         dq      5.5, 4.4, 3.3, 2.2, 3.0
        NMax            dq      100000.0
        N               equ     5
        strFormat       db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rsi, -1         ; -1: в конце увеличим на 1, т.к. будем вести отсчёт с 1, тогда получим 0, если ответ верный
        mov     rcx, N
        mov     rdi, series1
        movsd   xmm0, [NMax]
loop_i:
        test    rcx, rcx
        jz      done
        movsd   xmm1, [rdi]
        movsd   xmm2, xmm1
        cmppd   xmm1, xmm0, 0EH
        movq    rax, xmm1
        test    rax, rax
        jnz     done            ; следующий больше - на выход
        movsd   xmm0, xmm2      ; <- пред.
        dec     rcx
        add     rdi, 8
        jmp     loop_i
done:
        ; если rcx==0, то всё нормально, иначе встретилось число
        cmp     rcx, 0
        je      print
        mov     rax, N
        sub     rax, rcx
        mov     rcx, rax
        inc     rcx
print:
        mov     rsi, rcx
        mov     rax, 0
        mov     rdi, strFormat
        ; rsi - № или 0
        call    printf
        
        leave
        ret
