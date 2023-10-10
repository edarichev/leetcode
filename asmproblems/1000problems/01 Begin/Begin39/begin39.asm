; Begin39 . Найти корни квадратного уравнения A·x 2 + B·x + C = 0, заданного
; своими коэффициентами A, B, C (коэффициент A не равен 0), если известно, 
; что дискриминант уравнения положителен. Вывести вначале меньший,
; а затем больший из найденных корней. Корни квадратного уравнения 
; находятся по формуле x 1,2 = ( − B ± SQRT(D) ) / (2· A ), где D — дискриминант , равный B^2 – 4· A · C .
; Вывод:
; при 5x^2-7x+2=0:
; x1 = 1, x2 = 0.4
; при 7x^2-25x+23=0: (тут D<0)
; no roots
extern  printf
section .data
        ; 5x^2-7x+2=0
        A       dq      5.0
        B       dq      -7.0
        C       dq      2.0
        A1      dq      7.0
        B1      dq      -25.0
        C1      dq      23.0
        strFormat       db      "x1 = %g, x2 = %g",10,0
        strFormatEmpty  db      "no roots",10,0
section .bss
        x1      resq    1
        x2      resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        movsd   xmm2, [C]
        call    equation
        ; выводим
        test    rax, rax
        jz      nosqrt
        mov     rdi, strFormat
        ; кол-во вещественных чисел - уже в rax
        ; результаты - в xmm0, xmm1
        jmp     showresult
nosqrt:
        mov     rdi, strFormatEmpty
showresult:
        call    printf
        
        leave
        ret
equation:
        ; Решает квадратное уравнение
        ; Вход:
        ; A - xmm0, B - xmm1, C - xmm2
        ; выход:
        ; eax - число корней
        ; xmm0 - x1
        ; xmm1 - x2
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm3, xmm0
        movsd   xmm4, xmm1
        movsd   xmm5, xmm2
        ; дискриминант
        movsd   xmm7, xmm4      ; B
        mulsd   xmm7, xmm7      ; B^2
        mov     rax, 4
        cvtsi2sd xmm6, rax      ; 4 -> 4.0
        mulsd   xmm6, xmm3      ; 4*A
        mulsd   xmm6, xmm5      ; 4A*C
        subsd   xmm7, xmm6      ; B^2-4AC
        ; нужно проверить, не меньше ли D нуля
        pxor    xmm0, xmm0      ; 0
        movsd   xmm1, xmm7      ; нужно скопировать, т.к...
        cmpltsd xmm1, xmm0      ; ... если меньше, то в первый операнд будут занесены 1 во все биты
        movq    rax, xmm1       ; копируем 8 байт xmm1->rax
        test    rax, rax        ; операция И для получения флага ZF
        jnz     .err            ; да, меньше
        sqrtsd  xmm7, xmm7      ; корень из дискриминанта
        ; 2A
        mov     rax, 2
        cvtsi2sd xmm6, rax      ; 2->2.0
        mulsd   xmm6, xmm3      ; 2A, понадобится два раза, сохраним в xmm6
        ; -B
        pxor    xmm3, xmm3      ; 0
        subsd   xmm3, xmm4      ; 0-B=-B, сохраним это в xmm1, понадобится ещё
        ; x1
        movsd   xmm0, xmm3      ; -B
        addsd   xmm0, xmm7      ; +SQRT(D)
        divsd   xmm0, xmm6      ; /2A
        ; x2
        movsd   xmm1, xmm3      ; -B
        subsd   xmm1, xmm7      ; -SQRT(D)
        divsd   xmm1, xmm6      ; /2A
        mov     rax, 2
        leave
        ret
.err:
        mov     rax, 0
        leave
        ret
