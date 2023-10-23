; For34 . Дано целое число N (> 1). Последовательность вещественных чисел A K
; определяется следующим образом:
; A 1 = 1,
; A 2 = 2,
; A K = ( A K–2 + 2· A K–1 )/3, K = 3, 4, ... .
; Вывести элементы A 1 , A 2 , ..., A N .
;
; Вывод:
; 1  2  1.66667  1.33333  0.866667  0.511111  0.269841  0.131349  0.0591711  0.0249691
extern  printf
section .data
        A1              dq      1.0
        A2              dq      2.0
        N               equ     10
        strFormat       db      "%g  ",0
        strFormatStart  db      "%g  %g  ",0
        NL              db      10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rax, 2
        mov     rdi, strFormatStart
        movsd   xmm0, [A1]
        movsd   xmm1, [A2]
        call    printf
        and     rsp, 0xfffffffffffffff0 ; для выравнивания по 16 - ниже будут xmm-регистры и нечётное число 8-байтных регистров
        mov     rcx, 3
        movsd   xmm0, [A1]
        movsd   xmm1, [A2]
for_loop:
        cmp     rcx, N
        jg      exit
        
        cvtsi2sd xmm3, rcx
        movsd   xmm4, xmm1      ; текущее значение Ak
        addsd   xmm4, xmm4      ; ==2Ak-1
        addsd   xmm4, xmm0      ; 2*Ak-1 + Ak-2
        divsd   xmm4, xmm3      ; /k
        movsd   xmm0, xmm1      ; перемещаем элементы
        movsd   xmm1, xmm4
        
                                ; перед каждым вызовом функции стек должен быть выровнен на 16 байт
        push    rcx             ; rcx - это 8 байт, но нужно выровнять по 16, 
        sub     rsp, 8          ; поэтому уменьшим ещё на 8
        sub     rsp, 16
        movq    qword [rsp], xmm0
        sub     rsp, 16
        movq    qword [rsp], xmm1
        
        mov     rax, 1
        mov     rdi, strFormat
        movsd   xmm0, xmm1
        call    printf
        
        movq    xmm1, qword [rsp]
        add     rsp, 16
        movq    xmm0, qword [rsp]
        add     rsp, 16
        add     rsp, 8          ; выравнивание по 16, до сохранённого rcx ещё 8
        pop     rcx
        
        inc     rcx
        
        jmp     for_loop
exit:
        mov     rax, 0
        mov     rdi, NL
        call    printf
        leave
        ret
