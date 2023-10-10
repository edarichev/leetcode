; Begin29 . Дано значение угла α в градусах (0 < α < 360). Определить значение
; этого же угла в радианах, учитывая, что 180° = π радианов. В качестве значения π использовать 3.14.
; Вывод:
; a = 45, f=0.785
extern  printf
section .data
        PI      dq      3.14
        a       dq      45.0
        strFormat       db      "a = %g, f=%g",10,0
section .bss
        f       resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; f = a * PI / 180
        movsd   xmm0, [a]
        mulsd   xmm0, [PI]
        mov     rax, 180
        cvtsi2sd xmm1, rax
        divsd   xmm0, xmm1
        movsd   [f], xmm0
                
        ; выводим
        mov     rdi, strFormat
        movsd   xmm0, [a]
        movsd   xmm1, [f]
        mov     rax, 2          ; кол-во вещественных чисел
        call    printf
        
        leave
        ret
