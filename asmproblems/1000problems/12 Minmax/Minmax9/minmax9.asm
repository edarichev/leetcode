; Minmax9. Дано целое число N и набор из N целых чисел. Найти номера первого
; и последнего максимального элемента из данного набора и вывести их в
; указанном порядке.
;
; Вывод:
; Max1=5, Max2=7

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      7,1,4,2,6,9,2,9,1
        N               equ     9
        Min             dq      LONG_MAX
        Max             dq      LONG_MIN
        strFormat       db      "Max1=%d, Max2=%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     r8, LONG_MIN    ; r8 == max1
        mov     r10, -1         ; № макс1
        mov     r11, -1         ; № макс2
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, r8
        jl      next
        je      move_max2
        ; ещё меньше, меняем оба индекса и сам элемент
        mov     r10, rcx
        mov     r8, rax
move_max2:
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
