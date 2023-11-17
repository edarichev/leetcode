; Minmax30. Дано целое число N и набор из N целых чисел. Найти минимальное
; количество подряд идущих максимальных элементов из данного набора.
;
; Вывод:
; 2             (9,9)
; (в предыдущих задачах не учитывался последний элемент)

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      1,9,9,9,9,1,9,9
        N               equ     8
        strFormat       db      "%ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     rbx, LONG_MAX   ; макс. кол-во
        xor     rdx, rdx        ; длина текущей последовательности, сюда будем складывать временно, в начале 0
        mov     r8, LONG_MIN    ; r8==максимальный
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, r8
        jg      new_max
        jl      less
        ; максимум тот же
        inc     rdx
        jmp     next
new_max:
        mov     r8, rax
        mov     rdx, 1
        mov     rbx, LONG_MAX
        jmp     next
less:
        cmp     rdx, rbx
        jg      reset_current
        ; здесь заменить
        mov     rbx, rdx
reset_current:
        xor     rdx, rdx
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        cmp     r8, rax         ; последний элемент не проверен и максимальный, достаточно на равенство и взять счётчик из rdx
        jne     write
        mov     rbx, rdx
write:
        mov     rsi, rbx
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
