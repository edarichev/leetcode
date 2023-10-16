; If17 . Даны три переменные вещественного типа: A , B , C . Если их значения 
; упорядочены по возрастанию или убыванию, то удвоить их; в противном случае 
; заменить значение каждой переменной на противоположное. Вывести
;новые значения переменных A , B , C .
;
; Вывод:
; 15, 20, 11 -> -15, -20, -11
; 3, 2, 1 -> 2, 4, 6
; 1, 2, 3 -> 2, 4, 6
extern  printf

section .data
        A               dq      3.0;15.0
        B               dq      3.0;20.0
        C               dq      1.0
        strFormat       db      "%g, %g, %g -> %g, %g, %g",10,0
section .bss
        A1              resq    1
        B1              resq    1
        C1              resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        ; поскольку при сравнении регистры затираются, занесём значения в регистры xmm5, xmm6, xmm7
        ; заносим изначальный набор:
        movsd   xmm5, [A]
        movsd   xmm6, [B]
        movsd   xmm7, [C]

        ; проверить по возрастанию
        movsd   xmm0, xmm5
        cmplepd  xmm0, xmm6
        movq    rax, xmm0
        test    rax, rax
        jz      checkDesc
        movsd   xmm0, xmm6
        cmplepd xmm0, xmm7
        movq    rax, xmm0
        test    rax, rax
        jz      checkDesc       ; всё ещё возможно, например: 5, 5, 4
        jmp     mul2
checkDesc:
        ; проверить по убыванию
        movsd   xmm0, xmm5
        cmppd   xmm0, xmm6, 0Dh ; xmm0 >= xmm6
        movq    rax, xmm0
        test    rax, rax
        jz      negate
        movsd   xmm0, xmm6
        cmppd   xmm0, xmm7, 0Dh ; xmm0 >= xmm7
        jz      negate
mul2:
        ; *2
        mov     rax, 2
        cvtsi2sd xmm0, rax
        mulsd   xmm5, xmm0
        mulsd   xmm6, xmm0
        mulsd   xmm7, xmm0
        jmp     done
negate:
        ; порядка нет, заменим знак
        mov     rax, 0x8000000000000000
        movq    xmm0, rax
        pxor    xmm5, xmm0
        pxor    xmm6, xmm0
        pxor    xmm7, xmm0
done:
        movsd   [A1], xmm5
        movsd   [B1], xmm6
        movsd   [C1], xmm7
        ; вывод
        mov     rax, 6          ; кол-во вещественных
        mov     rdi, strFormat
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        movsd   xmm2, [C]
        movsd   xmm3, [A1]
        movsd   xmm4, [B1]
        movsd   xmm5, [C1]
        call    printf
        leave
        ret
