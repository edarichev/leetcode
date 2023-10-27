; While30 . Даны положительные числа A , B , C . На прямоугольнике размера A × B
; размещено максимально возможное количество квадратов со стороной C
; (без наложений). Найти количество квадратов, размещенных на прямоугольнике. 
; Операции умножения и деления не использовать.
;
; Вывод:
; N=8

extern  printf
section .data
        A               equ     13
        B               equ     7
        C               equ     3
        strFormat       db      "N=%d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; делить нельзя, поэтому в цикле идём пока не превысим
        xor     rax, rax        ; по стороне A
        xor     rbx, rbx        ; по стороне B
        xor     rcx, rcx        ; кол-во, перед каждым циклом сбросим
loop_a:
        add     rax, C
        cmp     rax, A
        jge     check_b
        inc     rcx
        jmp     loop_a
check_b:
        mov     rax, rcx
        xor     rcx, rcx
loop_b:
        add     rbx, C
        cmp     rbx, B
        jg      done
        inc     rcx
        jmp     loop_b
done:
        mov     rbx, rcx
        imul    rax, rbx
        mov     rsi, rax
        
        mov     rax, 0
        mov     rdi, strFormat
        ; rsi - кол-во
        call    printf
        leave
        ret
