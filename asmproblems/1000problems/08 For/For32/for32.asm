; For32 . Дано целое число N (> 0). Последовательность вещественных чисел A K
; определяется следующим образом:
; A 0 = 1,
; A K = ( A K–1 + 1)/ K , K = 1, 2, ... .
; Вывести элементы A 1 , A 2 , ..., A N .
;
; Вывод:
; 1  2  1.5  0.833333  0.458333  0.291667  0.215278  0.173611  0.146701  0.127411  0.112741
extern  printf
section .data
        A               dq      1.0
        N               equ     10
        strFormat       db      "%g  ",0        ; tab
        NL              db      10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rdi, strFormat
        mov     rax, 1
        movsd   xmm0, [A]
        call    printf
        
        movsd   xmm0, [A]       ; A (k-1), снова заносим, т.к. printf его затёр
        movsd   xmm1, xmm0      ; const, 1.0 в числитель, т.к. здесь xmm0==A==1.0
        
        mov     rcx, 1
        mov     rbx, N
for_loop:
        cmp     rcx, rbx
        jg      exit
        cvtsi2sd xmm2, rcx
        addsd   xmm0, xmm1      ; A(K-1) + 1
        divsd   xmm0, xmm2
        
        sub     rsp, 16
        movq    qword [rsp], xmm0
        sub     rsp, 16
        movq    qword [rsp], xmm1
        push    rbx
        push    rcx
        
        mov     rdi, strFormat
        mov     rax, 1
        call    printf
        
        pop     rcx
        pop     rbx
        movq    xmm1, qword [rsp]
        add     rsp, 16
        movq    xmm0, qword [rsp]
        add     rsp, 16
        
        inc     rcx
        jmp     for_loop
exit:
        mov     rax, 0
        mov     rdi, NL
        call    printf
        leave
        ret
