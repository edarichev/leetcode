; Proc38 . Описать функцию Power2( A , N ) вещественного типа, находящую величину 
; A^N ( A — вещественный, N — целый параметр) по следующим формулам:
; A^0 = 1;
; A^N = A·A·...·A (N сомножителей), если N > 0;
; A^N = 1/(A·A·...·A) (|N| сомножителей), если N < 0.
; С помощью этой функции найти A K , A L , A M , если даны числа A, K, L, M.
;
; Вывод:
; 3^-5 = 0.00411523
; 3^0 = 1
; 3^5 = 243


extern  printf

%macro  CALL_POWER1 2
        movq    xmm0, [%1]
        mov     rdi, [%2]
        call    Power2
        mov     rax, 1
        mov     rdi, strFormat
        mov     rsi, [%2]
        movq    xmm1, xmm0
        movq    xmm0, [%1]
        call    printf
%endmacro

section .data
        A               dq      3.0
        K               dq      -5
        L               dq      0
        M               dq      5
        strFormat       db      "%g^%d = %g",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        CALL_POWER1     A, K
        CALL_POWER1     A, L
        CALL_POWER1     A, M
        
        leave
        ret


Power2:
        ; Вход: 
        ;       xmm0 - A
        ;       rdi  - B (степень)
        ; Выход: rax
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        movq    xmm1, xmm0
        cmp     rdi, 0          ; == 0 ?
        je      .set_1
        jl      .set_less0
        ; тут > 0
.loop_pow:
        dec     rdi             ; т.к. 1 степень уже есть
        test    rdi, rdi
        jz      .exit
        mulsd   xmm1, xmm0
        jmp     .loop_pow
.set_less0:
        mov     rax, 1
        cvtsi2sd xmm1, rax
.loop_pow_neg:
        test    rdi, rdi
        jz      .exit
        divsd   xmm1, xmm0
        inc     rdi
        jmp     .loop_pow_neg
.set_1:
        mov     rax, 1
        cvtsi2sd xmm1, rax
.exit:
        movq    xmm0, xmm1
        leave
        ret
