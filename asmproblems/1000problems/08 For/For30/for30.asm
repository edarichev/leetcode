; For30 . Дано целое число N (> 1) и две вещественные точки на числовой оси:
; A , B ( A < B ). Отрезок [ A , B ] разбит на N равных отрезков. Вывести H —
; длину каждого отрезка, а также значения функции F ( X ) = 1 – sin( X ) в точках, разбивающих отрезок [ A , B ]:
; F ( A ), F ( A + H ), F ( A + 2· H ), ..., F ( B ).
;
; Вывод:
; H = 0.12
;  0.60  0.72  0.84  0.96  1.08  1.20  1.32  1.44  1.56  1.68  1.80
extern  printf
section .data
        A               dq      0.6
        B               dq      1.8
        N               equ     10
        strFormatN      db      "H = %g",10,0
        strFormat       db      "%g -> %g",10,0
        NL              db      10,0
section .bss
        X               resq    1
        Y               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm1, [A]
        movsd   xmm2, [B]
        movsd   xmm3, xmm2
        subsd   xmm3, xmm1
        mov     rax, N
        cvtsi2sd xmm0, rax
        divsd   xmm3, xmm0      ; xmm3 == dx
        
        sub     rsp, 16
        movq    qword [rsp], xmm1
        sub     rsp, 16
        movq    qword [rsp], xmm2
        sub     rsp, 16
        movq    qword [rsp], xmm3

        mov     rax, 1
        mov     rdi, strFormatN
        movsd   xmm0, xmm3
        call    printf

        movq    xmm3, qword [rsp]
        add     rsp, 16
        movq    xmm2, qword [rsp]
        add     rsp, 16
        movq    xmm1, qword [rsp]
        add     rsp, 16
        mov     rcx, 0
        mov     rbx, N
for_loop:
        cmp     rcx, rbx
        jg      exit
        
        movsd   [X], xmm1
        finit
        fld     qword [X]
        fsin
        fstp    qword [Y]
        movsd   xmm4, [Y]
        
        push    rbx
        push    rcx
        sub     rsp, 16
        movq    qword [rsp], xmm1
        sub     rsp, 16
        movq    qword [rsp], xmm2
        sub     rsp, 16
        movq    qword [rsp], xmm3
        
        mov     rax, 2
        mov     rdi, strFormat
        movsd   xmm0, xmm1
        movsd   xmm1, xmm4
        call    printf
        
        movq    xmm3, qword [rsp]
        add     rsp, 16
        movq    xmm2, qword [rsp]
        add     rsp, 16
        movq    xmm1, qword [rsp]
        add     rsp, 16
        pop     rcx
        pop     rbx
        inc     rcx
        
        addsd   xmm1, xmm3
        
        jmp     for_loop
exit:
        mov     rax, 0
        mov     rdi, NL
        call    printf
        leave
        ret
