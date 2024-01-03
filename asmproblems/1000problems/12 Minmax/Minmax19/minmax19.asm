; Minmax19. Дано целое число N и набор из N целых чисел. Найти количество
; минимальных элементов из данного набора.
;
; Вывод:
; 3

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      -1,2,3,4,5,-1,8,9,5,-1
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
        mov     rbx, LONG_MAX   ; минимальный
        mov     rdx, 0          ; кол-во
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, rbx
        jg      next
        jl      less
        ; тут равно, значит, увеличть кол-во
        inc     rdx
        jmp     next
less:
        ; строго меньше, начинаем подсчёт заново
        mov     rdx, 1          ; 1 штука
        mov     rbx, rax        ; новый минимум
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
