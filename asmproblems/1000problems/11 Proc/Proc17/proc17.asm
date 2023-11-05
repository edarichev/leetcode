; Proc17 . Описать функцию RootCount( A , B , C ) целого типа, определяющую 
; количество корней квадратного уравнения A · x^2 + B · x + C = 0 ( A , B , C — 
; вещественные параметры, A ≠ 0). С ее помощью найти количество корней для
; каждого из трех квадратных уравнений с данными коэффициентами. 
; Количество корней определять по значению дискриминанта : D = B^2 – 4· A · C .
;
; Вывод:
; (1)x² + (2)x + (-3) = 0 -> 2
; (1)x² + (2)x + (3) = 0 -> 0
; (1)x² + (4)x + (4) = 0 -> 1

extern  printf
section .data
        A               dq      1.0
        B               dq      4.0
        C               dq      4.0
        strFormat       db      "(%g)x² + (%g)x + (%g) = 0 -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        movsd   xmm0, [A]
        movsd   xmm1, [B]
        movsd   xmm2, [C]
        call    RootCount
        
        mov     rsi, rax
        mov     rax, 3
        mov     rdi, strFormat
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        movsd   xmm2, [C]
        call    printf
        
        leave
        ret

RootCount:
        ; RootCount
        ; Вход: xmm0 - A, xmm1 - B, xmm2 - C
        ; Выход: rax: 0, 1, 2
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        xor     rax, rax
        ; D = B^2 – 4· A · C
        movsd   xmm4, xmm1
        mulsd   xmm4, xmm4      ; B^2
        movsd   xmm5, xmm0
        addsd   xmm5, xmm5      ; A+A=2A
        addsd   xmm5, xmm5      ; 2A+2A=4A
        mulsd   xmm5, xmm2      ; 4AC
        subsd   xmm4, xmm5
        movq    rbx, xmm4
        test    rbx, rbx
        jnz     .test_next
        mov     rax, 1          ; D==0, rax <- 1
        jmp     .exit_sign
.test_next:
        shr     rbx, 63
        test    rbx, rbx
        jnz     .exit_sign      ; rax==0, D<0
        ; остался вариант D>0 -> rax <- 2
        mov     rax, 2
.exit_sign:
        leave
        ret
