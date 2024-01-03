; Minmax14. Дано число B (> 0) и набор из десяти чисел. Вывести минимальный
; из тех элементов набора, которые больше B, а также его номер. Если чисел,
; больших B, в наборе нет, то дважды вывести 0.
;
; Вывод:
; 6, №=9 (в этой задаче нумеруем с 1)
; 0, №=0 (если нет)

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        B               equ     5
        series1         dq      1,2,3,4,5,-7,-8,-9,-6,-8
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
        mov     rbx, LONG_MAX
        mov     rdx, -1                  ; тут номер, совпадёт с параметром строки формата, отсчёт с 1, поэтому потом +1
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, B                  ; сравним с B
        jle     next
        cmp     rax, rbx                ; теперь сравним с минимальным
        jg      next
        mov     rbx, rax
        mov     rdx, rcx
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        inc     rdx                     ; т.к. с 1, а 0 == отсутствие
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
