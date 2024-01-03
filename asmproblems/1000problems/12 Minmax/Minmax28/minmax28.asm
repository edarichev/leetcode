; Minmax28. Дано целое число N и набор из N целых чисел, содержащий только
; нули и единицы. Найти номер элемента, с которого начинается самая
; длинная последовательность единиц, и количество элементов в этой 
; последовательности. Если таких последовательностей несколько, то вывести
; номер последней из них. Если единицы в исходном наборе отсутствуют, то
; дважды вывести 0.
;
; Вывод:
; №=8, C=4

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      0,1,1,1, 1,0,0,0, 1,1,1,1, 0,0,0,0, 0
        N               equ     17
        strFormat       db      "№=%ld, C=%ld",10,0
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
        mov     r8, 0           ; номер элемента, с которого началась искомая последовательность
        mov     r9, -1          ; номер элемента, с которого началась текущая последовательность
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, 1
        jne     zero
        ; здесь 1
        inc     rdx
        jmp     next
zero:   ; встретили 0
        ; нужно проверить, какой длины была последовательность
        cmp     rdx, rbx
        jl      clear_counter
        mov     r8, r9          ; заменить индекс
        mov     rbx, rdx        ; заменить на большую или равную длину
clear_counter:
        mov     r9, rcx
        inc     r9              ; это позволит не проверять каждый раз в ветке "==1" начальный счётчик r9
        xor     rdx, rdx
next:
        mov     rdi, rax
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        mov     rsi, r8
        mov     rdx, rbx
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
