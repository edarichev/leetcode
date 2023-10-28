; While22 ° . Дано целое число N (> 1). Если оно является простым , то есть не
; имеет положительных делителей, кроме 1 и самого себя, то вывести True,
; иначе вывести False.
;
; Вывод:
; True (N = 11)

extern  printf
section .data
        N               equ     8
        strTrue         db      "True",10,0
        strFalse        db      "False",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rdi, strFalse   ; можно сразу поставить False, чтобы меньше прыгать
        mov     rax, N
        cdq
        mov     rbx, 2
        idiv    rbx             ; можно проверить только до N/2
        mov     rbx, rax
        mov     rcx, 2
loop_i:
        cmp     rcx, rbx
        jg      labelTrue       ; нет смысла дальше искать
        mov     rax, N
        cdq
        idiv    rcx
        test    rdx, rdx
        jz      done            ; делится без остатка
        inc     rcx
        jmp     loop_i
labelTrue:
        mov     rdi, strTrue
        jmp     done
done:
        mov     rax, 0
        call    printf
        leave
        ret
