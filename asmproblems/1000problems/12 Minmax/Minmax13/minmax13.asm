; Minmax13. Дано целое число N и набор из N целых чисел. Найти номер первого 
; максимального нечетного числа из данного набора. Если нечетные числа 
; в наборе отсутствуют, то вывести 0.
;
; Вывод:
; E=-1 (при всех < 0)
; E=0 (если нет)

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      -70,-10,-4,-10,-6,-90,-20,-90,-2
        N               equ     9
        Min             dq      LONG_MAX
        Max             dq      LONG_MIN
        strFormat       db      "E=%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     rbx, LONG_MIN           ; == max, по условию тут будет потом 0, если >0 нет
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        test    rax, 1                  ; нечётное заканчивается на 1
        jz      next                    ; 0, чётное
        cmp     rax, rbx
        jl      next
        mov     rbx, rax
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        mov     rax, LONG_MIN
        xor     rax, rbx
        jnz     write
        xor     rbx, rbx
write:
        mov     rsi, rbx
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
