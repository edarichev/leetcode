; While23 ° . Даны целые положительные числа A и B . Найти их наибольший общий делитель (НОД), используя алгоритм Евклида :
; НОД( A , B ) = НОД( B , A mod B ), если B ≠ 0;
; НОД( A , 0) = A ,
; где «mod» обозначает операцию взятия остатка от деления.
;
; Вывод:
; 12, 8 -> 4

extern  printf
section .data
        A               equ     12
        B               equ     8
        strFormat       db      "%d, %d -> %d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rax, A          ; rax <-> A
        mov     rbx, B          ; rbx <-> B
loop_i:
        test    rbx, rbx        ; B == 0? -> stop
        jz      done
        mov     rcx, rbx        ; A mod B
        cdq
        idiv    rcx
        mov     rax, rbx        ; A <- B
        mov     rbx, rdx        ; B <- остаток от деления
        jmp     loop_i
done:
        mov     rcx, rax
        mov     rax, 0
        mov     rdi, strFormat
        mov     rsi, A
        mov     rdx, B
        call    printf
        leave
        ret
