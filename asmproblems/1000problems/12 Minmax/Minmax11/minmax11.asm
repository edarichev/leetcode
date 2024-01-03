; Minmax11. Дано целое число N и набор из N целых чисел. Найти номер 
; последнего экстремального (то есть минимального или максимального) элемента из данного набора.
;
; Вывод:
; E=7

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      7,1,4,2,6,9,2,9,2
        N               equ     9
        Min             dq      LONG_MAX
        Max             dq      LONG_MIN
        strFormat       db      "E=%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     r8, LONG_MAX    ; r8 == min
        mov     r9, LONG_MIN    ; r9 == max
        mov     r10, -1         ; № мин
        mov     r11, -1         ; № макс
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, r8
        jle     set_new_min
        cmp     rax, r9
        jge     set_new_max
        jmp     next
set_new_min:
        mov     r10, rcx
        mov     r8, rax
        jmp     next
set_new_max:
        mov     r11, rcx
        mov     r9, rcx
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        mov     rsi, r10
        cmp     r10, r11
        jle     write
        mov     rsi, r11
write:
        xor     rax, rax
        mov     rdi, strFormat
        mov     rdx, r11
        call    printf
        leave
        ret
