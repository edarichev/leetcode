; Minmax22. Дано целое число N (> 2) и набор из N чисел. Найти два наименьших 
; элемента из данного набора и вывести эти элементы в порядке возрастания их значений.
;
; Вывод:
; -1, 2

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      -1,2,3,4,5,-1,8,2,8,-1
        N               equ     10
        strFormat       db      "%ld, %ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     rbx, LONG_MAX   ; минимальный1
        mov     rdx, LONG_MAX   ; минимальный2
        ; минимальный1 считаем как обычно
        ; минимальный2 меняем только если он > минимальный1, если равен, то не меняем
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        ; минимальный1
        cmp     rax, rbx
        jge     check_min2
        mov     rbx, rax        ; новое значение минимальный1
        jmp     next
check_min2:
        ; минимальный2
        cmp     rax, rdx
        jge     next
        cmp     rax, rbx
        je      next            ; он должен быть > минимальный1
        mov     rdx, rax
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        mov     rsi, rbx
        ; rdx уже есть
        cmp     rsi, rdx
        jle     write           ; поменять местами, чтобы по возрастанию
        xchg    rsi, rdx
write:
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
