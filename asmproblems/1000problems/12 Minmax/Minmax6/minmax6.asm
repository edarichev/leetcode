; Minmax6. Дано целое число N и набор из N целых чисел. Найти номера первого
; минимального и последнего максимального элемента из данного набора и
; вывести их в указанном порядке.
;
; Вывод:
; Min=1, Max=7

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      7,1,4,2,6,9,2,9,1
        N               equ     9
        Min             dq      LONG_MAX
        Max             dq      LONG_MIN
        strFormat       db      "Min=%d, Max=%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     r8, LONG_MAX    ; r8 == min
        mov     r9, LONG_MIN    ; r9 == max
        mov     r10, -1         ; № мин
        mov     r11, -1         ; № макс
        ; первый минимальный: строго jl, тогда индекс останется на первом
        ; последний максимальный: нестрогое jge, тогда индекс будет сдвигаться
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, r8
        jge     check_max
        mov     r8, rax
        mov     r10, rcx
check_max:
        cmp     rax, r9
        jl      next
        mov     r9, rax
        mov     r11, rcx
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        
        xor     rax, rax
        mov     rdi, strFormat
        mov     rsi, r10
        mov     rdx, r11
        call    printf
        leave
        ret
