; Array25. Дан массив ненулевых целых чисел размера N. Проверить, образуют
; ли его элементы геометрическую прогрессию (см. задание Array4). Если
; образуют, то вывести знаменатель прогрессии, если нет — вывести 0.
;
; Вывод:
; 0     (arr)
; 1     (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      3, 2, 5, 1, 20, 4, 99, 160, 321, 20
        arr1            dq      1,2,4,8,16,32,64,128,256,512
        fmt             db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rsi, arr
        ; A, A·D, A·D^2 , A·D^3 , ... .
        ; ограничимся целыми
        mov     rbx, [rsi]
        add     rsi, 8
        mov     r9, rbx         ; первый член r9 == A
        
        mov     rax, [rsi]
        add     rsi, 8
        cdq
        idiv    r9
        mov     r8, rax         ; что осталось, r8 - это знаменатель прогрессии
        ; не будем усложнять и считаем, что остаток всегда д.б. == 0
        cmp     rdx, 0
        jne     error
        
        mov     rcx, N
        sub     rcx, 2          ; 2 просмотрено
        mov     rbx, r8
loop_i:
        test    rcx, rcx
        jz      break_i
        imul    rbx, r8         ; новая разница, == k*D
        mov     rax, [rsi]      ; новый член
        cdq
        idiv    rbx             ; Ak / D*k => должно быть равно A1
        cmp     rax, r9
        jne     error
        
        dec     rcx
        add     rsi, 8
        jmp     loop_i
error:
        mov     r8, 0
break_i:
        mov     rdi, fmt
        mov     rsi, r8
        call    printf
        
        leave
        ret
