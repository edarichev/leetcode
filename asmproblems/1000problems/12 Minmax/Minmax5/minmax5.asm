; Minmax5. Дано целое число N и набор из N пар чисел (m, v) — данные о массе
; m и объеме v деталей, изготовленных из различных материалов. Вывести
; номер детали, изготовленной из материала максимальной плотности, а
; также величину этой максимальной плотности. Плотность P вычисляется
; по формуле P = m/v.
;
; Вывод:
; p Max = 0

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      7.0,1.0, 4.0,2.0, 6.0,9.0, 2.0,8.0
        N               equ     4
        strFormat       db      "p Max = %g",10,0
        PMax            dq      0.0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        movsd   xmm0, [PMax]
        mov     r9, -1          ; индекс от 0; -1 - нет
loop_i:
        cmp     rcx, N
        je      done
        movsd   xmm1, qword [rsi]       ; m
        add     rsi, 8
        movsd   xmm2, qword [rsi]       ; v
        add     rsi, 8
        divsd   xmm1, xmm2      ; m/v
        movsd   xmm2, xmm0
        cmppd   xmm2, xmm1, 1   ; max<current?
        movq    rax, xmm2
        test    rax, rax
        jnz     next
        movsd   xmm0, xmm1
        mov     r9, rcx
next:
        inc     rcx
        jmp     loop_i
done:
        
        mov     rax, 1
        mov     rdi, strFormat
        ; xmm0 есть
        call    printf
        leave
        ret
