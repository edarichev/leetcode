; Series23 . Дано целое число N (> 2) и набор из N вещественных чисел. Набор
; называется пилообразным , если каждый его внутренний элемент либо
; больше, либо меньше обоих своих соседей (то есть является «зубцом»).
; Если данный набор является пилообразным, то вывести 0; в противном
; случае вывести номер первого элемента, не являющегося зубцом.
;
; Вывод:
; 4

extern  printf
section .data
        series1         dq      5.5, 8.4, 6.3, 2.2, 3.0
        N               equ     5
        strFormat       db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, N
        cmp     rcx, 2
        jle     exit                    ; недопустимое значение
        xor     rcx, rcx
        mov     rdi, series1
        ; возьмём первые два элемента в xmm0, xmm1
        ; если первый больше второго, в rax поставим "не 0", иначе - 0
        ; переместим xmm0 <- xmm1
        ; считаем новый элемент
        ; если rax == 1, то теперь xmm0 д.б. < xmm1, иначе - на выход
        mov     rbx, 0
        movq    xmm0, qword [rdi]
        add     rdi, 8
        movq    xmm1, qword [rdi]
        add     rdi, 8
        cmppd   xmm0, xmm1, 0EH         ; xmm0 > xmm1 ?
        movq    rax, xmm0               ; таким образом тут будет 0, если xmm0 < xmm1 и не 0, если наоборот
        add     rcx, 2
loop_i:
        cmp     rcx, N
        je      done
        movq    xmm0, xmm1
        movsd   xmm1, qword [rdi]
        test    rax, rax
        jz      checkGreater
        movq    rax, xmm1
        test    rax, rax
        jz      done
        mov     rax, 0
        jmp     next
checkGreater:
        cmppd   xmm0, xmm1, 01H
        movq    rax, xmm0
        test    rax, rax
        jnz     done
        mov     rax, 1
next:
        inc     rcx
        add     rdi, 8
        jmp     loop_i
done:
        cmp     rcx, N
        je      setTo0                   ; нормально
        jmp     print
setTo0:
        xor     rcx, rcx
print:
        mov     rdi, strFormat
        mov     rsi, rcx
        call    printf
exit:
        leave
        ret
