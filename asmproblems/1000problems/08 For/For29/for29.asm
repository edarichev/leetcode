; For29 . Дано целое число N (> 1) и две вещественные точки на числовой оси:
; A , B ( A < B ). Отрезок [ A , B ] разбит на N равных отрезков. Вывести H —
; длину каждого отрезка, а также набор точек
; A , A + H , A + 2· H , A + 3· H , ..., B ,
; образующий разбиение отрезка [ A , B ].
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
        strFormat       db      "%6.2f",0
        NL              db      10,0
section .bss
        
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
for_loop:
        movsd   xmm0, xmm1
        cmppd   xmm0, xmm2, 1   ; xmm0 < xmm1 ?
        movq    rax, xmm0
        test    rax, rax
        jz      exit
        
        sub     rsp, 16
        movq    qword [rsp], xmm1
        sub     rsp, 16
        movq    qword [rsp], xmm2
        sub     rsp, 16
        movq    qword [rsp], xmm3
        
        mov     rax, 1
        mov     rdi, strFormat
        movsd   xmm0, xmm1
        call    printf
        
        movq    xmm3, qword [rsp]
        add     rsp, 16
        movq    xmm2, qword [rsp]
        add     rsp, 16
        movq    xmm1, qword [rsp]
        add     rsp, 16
        
        addsd   xmm1, xmm3
        
        jmp     for_loop
exit:
        mov     rax, 1
        mov     rdi, strFormat
        movsd   xmm0, xmm2
        call    printf

        mov     rax, 0
        mov     rdi, NL
        call    printf
        
        leave
        ret
