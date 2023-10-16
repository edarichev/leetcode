; If9 . Даны две переменные вещественного типа: A , B . Перераспределить значения 
; данных переменных так, чтобы в A оказалось меньшее из значений,
; а в B — большее. Вывести новые значения переменных A и B .
;
; Вывод:
; 25.3, 20.1 -> 20.1, 25.3
extern  printf

section .data
        A               dq      25.3
        B               dq      20.1
        strFormat       db      "%g, %g -> %g, %g",10,0
section .bss
        A1              resq    1
        B1              resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        movsd   xmm0, [A]
        movsd   xmm2, xmm0
        movsd   xmm1, [B]
        ; cmppd   xmm0, xmm1, 02h ; если первый операнд меньше или равен второму, устанавливает 1 во все биты дорожки (сравнение упорядоченное, сигнальное)
        cmplepd xmm0, xmm1      ; синоним cmppd   xmm0, xmm1, 02h
        movmskpd rax, xmm0      ; если истина, то 0 и 1 биты == 1
        test    rax, 1          ; достаточно 1 бит проверить
        jnz     revertA         ; менять не нужно, A<B
        movsd   xmm0, xmm1      ; <- B
        movsd   xmm1, xmm2      ; <- копия A
        jmp     done
revertA:
        movsd   xmm0, xmm2
done:
        movsd   [A1], xmm0
        movsd   [B1], xmm1
        ; вывод: выбираем строку True/False по значению rax
        mov     rax, 4          ; кол-во вещественных
        mov     rdi, strFormat
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        movsd   xmm2, [A1]
        movsd   xmm3, [B1]
        call    printf
        leave
        ret
