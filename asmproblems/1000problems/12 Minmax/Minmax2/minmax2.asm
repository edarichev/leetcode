; Minmax2. Дано целое число N и набор из N прямоугольников, заданных своими
; сторонами — парами чисел (a, b). Найти минимальную площадь прямоугольника из данного набора.
;
; Вывод:
; Min S=7

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        ; стороны зададим парами ab ab ab в одной серии:
        series1         dq      7,1, 4,2, 6,9, 2,8
        N               equ     4
        Min             dq      LONG_MAX
        strFormat       db      "Min S=%ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, N
        mov     rsi, series1
        mov     r8, LONG_MAX    ; r8 == min
loop_i:
        test    rcx, rcx
        jz      done
        mov     rax, qword [rsi]        ; a
        add     rsi, 8
        mov     rbx, qword [rsi]        ; b
        add     rsi, 8
        imul    rax, rbx
        cmp     r8, rax
        jle     next
        mov     r8, rax
next:
        dec     rcx
        jmp     loop_i
done:
        mov     qword [Min], r8
        
        xor     rax, rax
        mov     rdi, strFormat
        mov     rsi, qword [Min]
        call    printf
        leave
        ret
