; Minmax15. Даны числа B, C (0 < B < C) и набор из десяти чисел. Вывести 
; максимальный из элементов набора, содержащихся в интервале (B, C), и его
; номер. Если требуемые числа в наборе отсутствуют, то дважды вывести 0.
;
; Вывод:
; 9, №=8
; 0, №=0

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        B               equ     5
        C               equ     10
        series1         dq      1,2,3,4,5,-7,-8,-9,-6,-10
        N               equ     10
        Min             dq      LONG_MAX
        Max             dq      LONG_MIN
        strFormat       db      "%ld, №=%ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     rbx, LONG_MIN
        mov     rdx, -1                  ; тут номер, совпадёт с параметром строки формата, отсчёт с 1, поэтому потом +1
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, B                  ; сравним с B
        jle     next
        cmp     rax, C                  ; < C ?
        jge     next
        cmp     rax, rbx                ; теперь сравним с максимальным
        jle     next
        mov     rbx, rax
        mov     rdx, rcx
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        inc     rdx                     ; т.к. с 1, а 0 == отсутствие
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
