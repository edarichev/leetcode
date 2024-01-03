; Proc23 . Описать функцию Quarter( x , y ) целого типа, определяющую номер 
; координатной четверти, в которой находится точка с ненулевыми вещественными 
; координатами ( x , y ). С помощью этой функции найти номера 
; координатных четвертей для трех точек с данными ненулевыми координатами.
;
; Вывод:
; (6, 5) -> 1
; (-6, 5) -> 2
; (-6, -5) -> 3
; (6, -5) -> 4

extern  printf

%macro  do_Quarter 2
        movsd   xmm0, %1
        movsd   xmm1, %2
        call    Quarter
        
        mov     rdi, strFormat
        mov     rsi, rax
        mov     rax, 2
        movsd   xmm0, %1
        movsd   xmm1, %2
        call    printf
%endmacro

section .data
        X1              dq      6.0
        Y1              dq      5.0
        X2              dq      -6.0
        Y2              dq      5.0
        X3              dq      -6.0
        Y3              dq      -5.0
        X4              dq      6.0
        Y4              dq      -5.0
        strFormat       db      "(%g, %g) -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        do_Quarter      [X1], [Y1]
        do_Quarter      [X2], [Y2]
        do_Quarter      [X3], [Y3]
        do_Quarter      [X4], [Y4]
        
        leave
        ret

Quarter:
        ; Вход: 
        ;       xmm0 - x, xmm1 - y
        ; Выход: rax: 1, 2, 3, 4
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp

        movq    rax, xmm0
        movq    rbx, xmm1
        shr     rax, 63         ; нужен знаковый бит, в double он старший
        shr     rbx, 63
        test    rax, rax
        jz      .q_1_4          ; x > 0?
        ; 2|3                   ; x<0
        test    rbx, rbx
        jz      .q_2            ; y > 0?
        mov     rax, 3
        jmp     .exit
.q_2:
        mov     rax, 2
        jmp     .exit
.q_1_4: ; x>0
        test    rbx, rbx
        jz      .q_1
        mov     rax, 4
        jmp     .exit
.q_1:
        mov     rax, 1
        jmp     .exit
.exit:
        leave
        ret

        
        
        
        
        
        
        
        
        
        
        
