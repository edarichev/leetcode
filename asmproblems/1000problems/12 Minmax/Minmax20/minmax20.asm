; Minmax20. Дано целое число N и набор из N целых чисел. Найти общее 
; количество экстремальных (то есть минимальных и максимальных) элементов
; из данного набора.
;
; Вывод:
; 5 (3 по -1 и 2 по 8)

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
        mov     rbx, LONG_MAX   ; минимальный
        mov     rdx, 0          ; кол-во минимальных
        mov     r8, LONG_MIN    ; максимальный
        mov     r9, 0           ; кол-во максимальных
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, rbx
        jg      check_greater
        jl      less
        ; тут равно минимальному, значит, увеличть кол-во
        inc     rdx
        jmp     next
less:
        ; строго меньше, начинаем подсчёт заново
        mov     rdx, 1          ; 1 штука
        mov     rbx, rax        ; новый минимум
        jmp     next
check_greater:
        ; тут > минимума, если мы тут, то только из ветки jg      check_greater
        cmp     rax, r8
        jg      greater
        jl      next            ; вряд ли возможно, но поставлю
        ; здесь только равнество
        inc     r9
        jmp     next
greater:
        ; новый максимум, заново
        mov     r9, 1
        mov     r8, rax
        jmp     next
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        mov     rsi, rdx
        add     rsi, r9
        
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
