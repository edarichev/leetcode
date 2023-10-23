; For31 . Дано целое число N (> 0). Последовательность вещественных чисел A K
; определяется следующим образом:
; A 0 = 2,
; A K = 2 + 1/ A K–1 , K = 1, 2, ... .
; Вывести элементы A 1 , A 2 , ..., A N .
;
; Вывод:
; 2  2.5  2.4  2.41667  2.41379  2.41429  2.4142  2.41422  2.41421  2.41421  2.41421
extern  printf
section .data
        A               dq      2.0
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
        
        movsd   xmm0, [A]       ; A (k-1)
        mov     rax, 1
        cvtsi2sd xmm1, rax      ; 1.0 в числитель
        
        mov     rcx, 1
        mov     rbx, N
for_loop:
        cmp     rcx, rbx
        jg      exit
        movsd   xmm2, xmm1      ; <- 1.0
        divsd   xmm2, xmm0      ; 1/A(k-1)
        movsd   xmm0, xmm2      ; новое значение A(K)
        addsd   xmm0, xmm1      ; +1
        addsd   xmm0, xmm1      ; +1 - итого это 2+1/A(k-1)
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
