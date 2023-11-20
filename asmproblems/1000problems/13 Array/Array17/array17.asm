; Array17. Дан массив A размера N. Вывести его элементы в следующем порядке:
; A 1 , A 2 , A N , A N–1 , A 3 , A 4 , A N–2 , A N–3 , ... .
;
; Вывод:
; 3 2 640 321 5 1 160 99 20 4 4 20 99 160 1 5 321 640 2 3

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10      ; сделаем чётное кол-во для простоты
        arr             dq      3, 2, 5, 1, 20, 4, 99, 160, 321, 640
        fmt             db      "%d %d %d %d ",0
        NL              db      10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 1
        mov     rsi, arr                ; с начала
        mov     rdi, arr + N*8 - 8      ; с конца
loop_i:
        cmp     rcx, N
        jg      exit_loop_i
        ; выведем сразу по 4
        mov     r8, qword [rsi]
        inc     rcx
        add     rsi, 8
        mov     r9, qword [rsi]
        inc     rcx
        add     rsi, 8
        
        mov     r10, qword [rdi]
        sub     rdi, 8
        mov     r11, qword [rdi]
        sub     rdi, 8
        
        push    rsi
        push    rcx
        push    rdi
        sub     rsp, 8

        mov     rsi, r8
        mov     rdx, r9
        mov     rcx, r10
        mov     r8, r11
        mov     rdi, fmt
        call    printf
        
        add     rsp, 8
        pop     rdi
        pop     rcx
        pop     rsi
        
        jmp     loop_i
exit_loop_i:

        mov     rdi, NL
        call    printf
        
        leave
        ret
