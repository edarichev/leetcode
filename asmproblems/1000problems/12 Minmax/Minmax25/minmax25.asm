; Minmax25. Дано целое число N (> 1) и набор из N чисел. Найти номера двух
; соседних чисел из данного набора, произведение которых является минимальным, 
; и вывести вначале меньший, а затем больший номер.
;
; Вывод:
; 5, 6

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
        mov     r10, LONG_MAX           ; минимальное произведение
        mov     rdx, qword [rsi]        ; предыдущий элемент
        inc     rcx
        add     rsi, 8
        mov     r11, -1                 ; индекс 1
        mov     r12, -1                 ; индекс 2
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        mov     rbx, rax
        imul    rbx, rdx
        cmp     rbx, r10
        jge     next
        mov     r10, rbx                ; новое произведение
        mov     r12, rcx
        mov     r11, r12
        dec     r11
next:
        mov     rdx, rax                ; меняем предыдущий
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        mov     rsi, r11
        mov     rdx, r12
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
