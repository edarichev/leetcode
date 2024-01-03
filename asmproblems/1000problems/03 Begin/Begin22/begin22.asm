; Begin22 °. Поменять местами содержимое переменных A и B и вывести новые значения A и B.
; Вывод:
; (-9, 4) -> (4, -9)
extern  printf

%macro EXCHANGEXMM 2
        pxor    %1, %2
        pxor    %2, %1
        pxor    %1, %2
%endmacro

section .data
        A      dq      -9.0
        B      dq      4.0
        strFormat       db      "(%g, %g) -> (%g, %g)",10,0
section .bss
        a       resq    1
        b       resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        
        ; обмен значениями вместо целочисленного XCHG:
        pxor    xmm0, xmm1
        pxor    xmm1, xmm0
        pxor    xmm0, xmm1
        
        ; порядок другой для вывода:
        movsd   xmm2, xmm0
        movsd   xmm3, xmm1
        ; оригинальные
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        ; выводим
        mov     rax, 2          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
