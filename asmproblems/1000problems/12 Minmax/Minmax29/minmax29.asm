; Minmax29. Дано целое число N и набор из N целых чисел. Найти максимальное
; количество подряд идущих минимальных элементов из данного набора.
;
; Вывод:
; 5             (1,1,1,1,1)

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      5,7,2,8,1,1,1,9,9,1,1,1,1,1,6
        N               equ     15
        strFormat       db      "%ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     rbx, 0          ; макс. кол-во
        xor     rdx, rdx        ; длина текущей последовательности, сюда будем складывать временно, в начале 0
        mov     r8, LONG_MAX    ; r8==минимальный
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, r8
        jl      new_min
        jg      reset
        inc     rdx             ; равно - считаем
        jmp     next
new_min:
        mov     r8, rax
        mov     rdx, 1          ; сброс длины, 1 - включить текущий элемент
        jmp     next
reset:
        cmp     rdx, rbx
        jg      replace_len
        jmp     reset_counter
replace_len:
        mov     rbx, rdx
reset_counter:
        xor     rdx, rdx
next:
        mov     rdi, rax
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
