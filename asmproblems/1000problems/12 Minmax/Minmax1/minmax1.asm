; Minmax1o. Дано целое число N и набор из N чисел. Найти минимальный и 
; максимальный из элементов данного набора и вывести их в указанном порядке.
;
; Вывод:
; Min=1, Max=9

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      7,1,4,2,6,9,2
        N               equ     7
        Min             dq      LONG_MAX
        Max             dq      LONG_MIN
        strFormat       db      "Min=%d, Max=%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, N
        mov     rsi, series1
        mov     r8, LONG_MAX    ; r8 == min
        mov     r9, LONG_MIN    ; r9 == max
loop_i:
        test    rcx, rcx
        jz      done
        mov     rax, qword [rsi]
        cmp     rax, r8
        jge     check_max
        mov     r8, rax
check_max:
        cmp     rax, r9
        jle     next
        mov     r9, rax
next:
        add     rsi, 8
        dec     rcx
        jmp     loop_i
done:
        mov     qword [Min], r8
        mov     qword [Max], r9
        
        xor     rax, rax
        mov     rdi, strFormat
        mov     rsi, qword [Min]
        mov     rdx, qword [Max]
        call    printf
        leave
        ret
