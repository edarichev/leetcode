; Minmax4. Дано целое число N и набор из N чисел. Найти номер минимального
; элемента из данного набора.
;
; Вывод:
; № Min = 1

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      7,1,4,2,6,9,2,8
        N               equ     8
        strFormat       db      "№ Min = %ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     r8, LONG_MAX    ; r8 == min
        mov     r9, -1          ; индекс от 0; -1 - нет
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        add     rsi, 8
        cmp     r8, rax
        jle     next
        mov     r8, rax
        mov     r9, rcx
next:
        inc     rcx
        jmp     loop_i
done:
        
        xor     rax, rax
        mov     rdi, strFormat
        mov     rsi, r9
        call    printf
        leave
        ret
