; For35 . Дано целое число N (> 2). Последовательность целых чисел A K определяется следующим образом:
; A 1 = 1,
; A 2 = 2,
; A 3 = 3,
; A K = A K–1 + A K–2 – 2· A K–3 , K = 4, 5, ... .
; Вывести элементы A 1 , A 2 , ..., A N .
;
; Вывод:
; 1  2  3  3  2  -1  -5  -10  -13  -13
extern  printf
section .data
        A1              dq      1
        A2              dq      2
        A3              dq      3
        N               equ     10
        strFormat       db      "  %d",0
        strFormatStart  db      "%d  %d  %d",0
        NL              db      10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rdi, strFormatStart
        mov     rsi, [A1]
        mov     rdx, [A2]
        mov     rcx, [A3]
        call    printf
        mov     rcx, 4
        mov     rax, [A1]
        mov     rbx, [A2]
        mov     rdx, [A3]
for_loop:
        cmp     rcx, N
        jg      exit
        
        mov     r8, -2
        imul    r8, rax         ; -2A(k-3)
        add     r8, rbx         ; +A(k-2)
        add     r8, rdx         ; +A(k-1)
        
        push    rcx             ; счётчик, а следующие переприсвоим через стек:
        push    rbx             ; это будет A(k-3)
        push    rdx             ; это будет A(k-2)
        push    r8              ; это будет A(k-1)
        
        mov     rdi, strFormat
        mov     rsi, r8
        call    printf
        
        pop     rdx             ; извлекая, заносим новые значения
        pop     rbx
        pop     rax
        pop     rcx
        inc     rcx
        
        jmp     for_loop
exit:
        mov     rax, 0
        mov     rdi, NL
        call    printf
        leave
        ret
