; Array50. Дан целочисленный массив A размера N, являющийся перестановкой
; (определение перестановки дано в задании Array49). Найти количество ин-
; версий в данной перестановке, то есть таких пар элементов A I и A J , 
; в которых большее число находится слева от меньшего: A I > A J при I < J.
;
; Вывод:
; 1      (arr)
; 36      (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      1,2,3,4,6,5,7,8,9,10
        arr1            dq      9,8,7,6,5,4,3,2,1,10
        strFormat       db      "%ld",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, 1          ; отсчёт с 1 по условию
        mov     rsi, arr1
        mov     r9, 0           ; ответ
loop_i:
        cmp     rcx, N-1
        jg      break_i
        mov     rax, qword [rsi]
        
        mov     rdi, rsi
        mov     rdx, rcx
        loop_j:
                inc     rdx             ; сразу rcx+1
                add     rdi, 8          ; со следующего
                cmp     rdx, N
                jg      break_j
                mov     rbx, qword [rdi]
                cmp     rax, rbx
                jl      loop_j
                inc     r9
                jmp     loop_j
        break_j:
        inc     rcx
        add     rsi, 8
        jmp     loop_i
break_i:

write:
        mov     rdi, strFormat
        mov     rsi, r9
        call    printf
        
        leave
        ret
