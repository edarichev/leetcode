; While17 . Дано целое число N (> 0). Используя операции деления нацело и взятия
; остатка от деления, вывести все его цифры, начиная с самой правой
; (разряда единиц).
;
; Вывод:
;   5  4  3  2  1

extern  printf
section .data
        N               equ     12345
        strFormat       db      "%3d",0
        NL              db      10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rax, N
loop_i:
        test    rax, rax
        jz      exit
        cdq
        mov     rbx, 10         ; делитель
        div     rbx
        push    rax
        sub     rsp, 8          ; выравнивание 16
        
        mov     rax, 0
        mov     rdi, strFormat
        mov     rsi, rdx
        call    printf
        add     rsp, 8          ; выравнивание 16
        pop     rax
        jmp     loop_i
exit:
        mov     rax, 0
        mov     rdi, NL
        call    printf
        leave
        ret
