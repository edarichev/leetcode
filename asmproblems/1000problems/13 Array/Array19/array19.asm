; Array19. Дан целочисленный массив A размера 10. Вывести порядковый номер
; последнего из тех его элементов A K , которые удовлетворяют двойному не-
; равенству A 1 < A K < A 10 . Если таких элементов нет, то вывести 0.
;
; Вывод:
; 6

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10      ; сделаем чётное кол-во для простоты
        arr             dq      3, 2, 5, 1, 20, 4, 99, 160, 321, 20
        fmt             db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 2
        mov     rsi, arr                ; с начала
        mov     rdx, [arr]              ; A1
        add     rsi, 8
        mov     rax, [arr + N*8 - 8]    ; с конца, A10
        mov     rbx, 0                  ; ответ
loop_i:
        cmp     rcx, N
        jge     exit_loop_i             ; от 2 и не выше N-1
        mov     r8, [rsi]
        cmp     r8, rax
        jge     next_i                  ; AK>=A10, смотрим следующий
        cmp     r8, rdx
        jle     next_i                  ; AK <= A1, смотрим следующий
        mov     rbx, rcx                ; нашли
next_i:
        inc     rcx
        add     rsi, 8
        jmp     loop_i
exit_loop_i:
        mov     rdi, fmt
        mov     rsi, rbx
        call    printf
        
        leave
        ret
