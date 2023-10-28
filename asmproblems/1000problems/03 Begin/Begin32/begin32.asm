; Begin32 . Дано значение температуры T в градусах Цельсия. Определить значение
; этой же температуры в градусах Фаренгейта. Температура по Цельсию
; T C и температура по Фаренгейту T F связаны следующим соотношением:
; T C = (T F – 32)·5/9.
; Вывод:
; TC = 26.6667, TF = 80.0001
extern  printf
section .data
        TC      dq      26.6667
        strFormat       db      "TC = %g, TF = %g",10,0
section .bss
        TF      resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; TF = TC *9/5 + 32
        movsd   xmm0, [TC]
        mov     rax, 9
        cvtsi2sd xmm1, rax
        mulsd   xmm0, xmm1
        mov     rax, 5
        cvtsi2sd xmm1, rax
        divsd   xmm0, xmm1
        mov     rax, 32
        cvtsi2sd xmm1, rax
        addsd   xmm0, xmm1
        movsd   [TF], xmm0
                
        ; выводим
        mov     rdi, strFormat
        movsd   xmm0, [TC]
        movsd   xmm1, [TF]
        mov     rax, 2          ; кол-во вещественных чисел
        call    printf
        
        leave
        ret
