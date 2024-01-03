; Minmax16. Дано целое число N и набор из N целых чисел. Найти количество
; элементов, расположенных перед первым минимальным элементом.
;
; Вывод:
; 7

; в-общем, это то же самое, что и индекс от 0 
extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      1,2,3,4,5,-7,-8,-9,-6,-1
        N               equ     10
        Min             dq      LONG_MAX
        Max             dq      LONG_MIN
        strFormat       db      "%ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     rbx, LONG_MAX
        mov     rdx, 0                   ; тут индекс
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, rbx
        jge     next
        mov     rbx, rax
        mov     rdx, rcx
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        mov     rsi, rdx
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
