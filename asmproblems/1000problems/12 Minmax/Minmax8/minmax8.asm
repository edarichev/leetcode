; Minmax8. Дано целое число N и набор из N целых чисел. Найти номера первого
; и последнего минимального элемента из данного набора и вывести их в
; указанном порядке.
;
; Вывод:
; Min1=1, Min2=8

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      7,1,4,2,6,9,2,9,1
        N               equ     9
        Min             dq      LONG_MAX
        Max             dq      LONG_MIN
        strFormat       db      "Min1=%d, Min2=%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     r8, LONG_MAX    ; r8 == min1
        mov     r10, -1         ; № мин1
        mov     r11, -1         ; № мин2
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, r8
        jg      next
        je      move_min2
        ; ещё меньше, меняем оба индекса и сам элемент
        mov     r10, rcx
        mov     r8, rax
move_min2:
        mov     r11, rcx
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        
        xor     rax, rax
        mov     rdi, strFormat
        mov     rsi, r10
        mov     rdx, r11
        call    printf
        leave
        ret
