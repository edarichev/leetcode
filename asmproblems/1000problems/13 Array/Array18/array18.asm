; Array18. Дан массив A ненулевых целых чисел размера 10. Вывести значение
; первого из тех его элементов A K , которые удовлетворяют неравенству
; A K < A 10 . Если таких элементов нет, то вывести 0.
;
; Вывод:
; 4

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10      ; сделаем чётное кол-во для простоты
        arr             dq      3, 2, 5, 1, 20, 4, 99, 160, 321, 2
        fmt             db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 1
        mov     rsi, arr                ; с начала
        mov     rax, [arr + N*8 - 8]    ; с конца, A10
        mov     rbx, 0                  ; ответ
loop_i:
        cmp     rcx, N
        jg      exit_loop_i
        cmp     [rsi], rax
        jl      exit_loop_i
        inc     rcx
        add     rsi, 8
        jmp     loop_i
exit_loop_i:
        cmp     rcx, N
        jg      write
        mov     rbx, rcx
write:
        mov     rdi, fmt
        mov     rsi, rbx
        call    printf
        
        leave
        ret
