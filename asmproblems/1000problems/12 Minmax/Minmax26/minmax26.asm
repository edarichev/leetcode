; Minmax26. Дано целое число N и набор из N целых чисел. Найти максимальное
; количество четных чисел в наборе, идущих подряд. Если четные числа в
; наборе отсутствуют, то вывести 0.
;
; Вывод:
; 3             (8,2,8)

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      -1,2,3,4,5,-1,8,2,8,-1
        N               equ     10
        strFormat       db      "%ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     rbx, LONG_MIN   ; макс. кол-во
        xor     rdx, rdx        ; сюда будем складывать временно
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        test    rax, 1
        jnz     odd
        inc     rdx
        jmp     next
odd:
        cmp     rdx, rbx        ; заменить, если последовательность длиннее
        jle     clear_counter
        mov     rbx, rdx
clear_counter:
        xor     rdx, rdx
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        mov     rsi, rbx
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
