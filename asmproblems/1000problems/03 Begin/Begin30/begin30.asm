; Begin30 . Дано значение угла α в радианах (0 < α < 2·π). Определить значение
; этого же угла в градусах, учитывая, что 180° = π радианов. В качестве значения π использовать 3.14.
; Вывод:
; f = 0.785, a = 45
extern  printf
section .data
        PI      dq      3.14
        f       dq      0.785
        strFormat       db      "f = %g, a = %g",10,0
section .bss
        a       resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; a = 180 * f/ PI
        movsd   xmm0, [f]
        mov     rax, 180
        cvtsi2sd xmm1, rax
        mulsd   xmm0, xmm1
        divsd   xmm0, [PI]
        movsd   [a], xmm0
                
        ; выводим
        mov     rdi, strFormat
        movsd   xmm0, [f]
        movsd   xmm1, [a]
        mov     rax, 2          ; кол-во вещественных чисел
        call    printf
        
        leave
        ret
