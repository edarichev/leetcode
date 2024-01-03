; Series28 . Дано целое число N и набор из N вещественных чисел: A 1 , A 2 , ..., A N .
; Вывести следующие числа:
; ( A 1 )^N , ( A 2 )^N–1 , ..., ( A N–1 )^2 , A N .
;
; Вывод:
; 1.331 4.84 3.3

extern  printf
section .data
        series1         dq      1.1,2.2,3.3
        N               equ     3
        strFormat       db      "%g ",0
        NL              db      10,0
section .bss
        result          resq    N
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rsi, series1
        mov     rdi, result
        mov     rcx, N
loop_i:
        test    rcx, rcx
        jz      break_i
        movsd   xmm0, qword [rsi]       ; это произведение, пусть K>=1
        movsd   xmm1, xmm0              ; копируем
                mov     rdx, rcx
                dec     rdx             ; 1 раз уже учтено
        loop_j:
                test    rdx, rdx
                jz      break_j
                mulsd   xmm0, xmm1
                dec     rdx
                jmp     loop_j
        break_j:
        movsd   qword [rdi], xmm0
        add     rdi, 8
        add     rsi, 8
        dec     rcx
        jmp     loop_i
break_i:
        mov     rcx, N
        mov     rdi, result
        and     rsp, 0xfffffffffffffff0
loop_k:
        test    rcx, rcx
        jz      done
        movsd   xmm0, qword [rdi]
        push    rcx
        push    rdi
        mov     rax, 1
        mov     rdi, strFormat
        mov     rsi, rdx
        call    printf
        pop     rdi
        pop     rcx
        dec     rcx
        add     rdi, 8
        jmp     loop_k
done:
        mov     rdi, NL
        call    printf
        leave
        ret
