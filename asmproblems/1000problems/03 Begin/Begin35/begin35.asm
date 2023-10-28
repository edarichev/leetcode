; Begin35 . Скорость лодки в стоячей воде V км/ч, скорость течения реки U км/ч
; (U < V). Время движения лодки по озеру T1 ч, а по реке (против течения) —
; T2 ч. Определить путь S, пройденный лодкой (путь = время · скорость).
; Учесть, что при движении против течения скорость лодки уменьшается на
; величину скорости течения.
; Вывод:
; S1 = 12.5, S2 = 6.75, S = 19.25
extern  printf
section .data
        V       dq      5.0
        U       dq      0.5
        T1      dq      2.5
        T2      dq      1.5
        strFormat       db      "S1 = %g, S2 = %g, S = %g",10,0
section .bss
        S1      resq    1
        S2      resq    1
        S       resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; S1 - в стоячей воде
        movsd   xmm0, [V]
        mulsd   xmm0, [T1]
        movsd   [S1], xmm0
        ; S2 - по реке, против течения, вычитаем V-U
        movsd   xmm1, [V]
        subsd   xmm1, [U]
        mulsd   xmm1, [T2]
        movsd   [S2], xmm1
        ; сумма всего пути: S1+S2
        movsd   xmm2, xmm0
        addsd   xmm2, xmm1
        ; выводим - регистры уже в нужном порядке
        mov     rdi, strFormat
        mov     rax, 3          ; кол-во вещественных чисел
        call    printf
        
        leave
        ret
