; Minmax12. Дано целое число N и набор из N чисел. Найти минимальное
; положительное число из данного набора. Если положительные числа в
; наборе отсутствуют, то вывести 0.
;
; Вывод:
; E=1
; E=0 (при всех < 0)

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      -7,-1,-4,-1,-6,-9,-2,-9,-2
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
        mov     rbx, LONG_MAX           ; == min, по условию тут будет потом 0, если >0 нет
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, 0
        jl      next
        cmp     rax, rbx
        jg      next
        mov     rbx, rax
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        mov     rax, LONG_MAX
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
