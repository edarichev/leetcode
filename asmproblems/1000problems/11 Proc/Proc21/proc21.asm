; Proc21 . Описать функцию SumRange( A , B ) целого типа, находящую сумму всех
; целых чисел от A до B включительно ( A и B — целые). Если A > B , то
; функция возвращает 0. С помощью этой функции найти суммы чисел от A
; до B и от B до C , если даны числа A , B , C .
;
; Вывод:
; ∑(1...5) = 15
; ∑(5...10) = 45


extern  printf

%macro  show_sum 2
        mov     rdi, %1
        mov     rsi, %2
        call    SumRange
        
        mov     rdi, strFormat
        mov     rsi, %1
        mov     rdx, %2
        mov     rcx, rax
        xor     rax, rax
        call    printf
%endmacro

section .data
        A               dq      1
        B               dq      5
        C               dq      10
        strFormat       db      "∑(%d...%d) = %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        show_sum        [A], [B]
        show_sum        [B], [C]
        
        leave
        ret

SumRange:
        ; Вход: rdi - a, rsi - b
        ; Выход: rax - S
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp

        xor     rax, rax
.loop_i:
        cmp     rdi, rsi
        jg      .exit
        add     rax, rdi
        inc     rdi
        jmp     .loop_i
.exit:
        leave
        ret
