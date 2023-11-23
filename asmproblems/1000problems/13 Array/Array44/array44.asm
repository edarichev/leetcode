; Array44. Дан целочисленный массив размера N, содержащий ровно два 
; одинаковых элемента. Найти номера одинаковых элементов и вывести эти номера в порядке возрастания.
;
; Вывод:
; 2,6      (arr)
; 4,6      (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      1,2,11,3,4,2,6,7,8,9
        arr1            dq      9,8,7,6,5,6,4,3,2,1
        strFormat       db      "%ld, %ld",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; поскольку массив может быть не упорядочен, то будет вложенный цикл
        mov     rcx, 1          ; отсчёт с 1 по условию
        mov     rsi, arr1
loop_i:
        cmp     rcx, N-1
        jg      break_i
        mov     rax, qword [rsi]
        
        mov     rdi, rsi
        mov     rdx, rcx
        loop_j:
                inc     rdx
                add     rdi, 8
                cmp     rdx, N
                jg      break_j
                mov     rbx, qword [rdi]
                cmp     rax, rbx
                je      break_i         ; вообще выйти, нашли
                jmp     loop_j
        break_j:
next:
        inc     rcx
        add     rsi, 8
        jmp     loop_i
break_i:
        mov     rdi, strFormat
        mov     rsi, rcx
        ; rdx - это второй индекс, уже есть
        call    printf
        
        leave
        ret
