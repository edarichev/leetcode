; Minmax3. Дано целое число N и набор из N прямоугольников, заданных своими
; сторонами — парами чисел (a, b). Найти максимальный периметр прямоугольника из данного набора.
;
; Вывод:
; Max P=30

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        ; стороны зададим парами ab ab ab в одной серии:
        series1         dq      7,1, 4,2, 6,9, 2,8
        N               equ     4
        Max             dq      LONG_MIN
        strFormat       db      "Max P=%ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, N
        mov     rsi, series1
        mov     r8, LONG_MIN    ; r8 == max
loop_i:
        test    rcx, rcx
        jz      done
        mov     rax, qword [rsi]        ; a
        add     rsi, 8
        mov     rbx, qword [rsi]        ; b
        add     rsi, 8
        add     rax, rbx
        imul    rax, 2
        cmp     r8, rax
        jge     next
        mov     r8, rax
next:
        dec     rcx
        jmp     loop_i
done:
        mov     qword [Max], r8
        
        xor     rax, rax
        mov     rdi, strFormat
        mov     rsi, qword [Max]
        call    printf
        leave
        ret
