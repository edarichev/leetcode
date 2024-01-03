; Begin31 . Дано значение температуры T в градусах Фаренгейта. Определить
; значение этой же температуры в градусах Цельсия. Температура по Цельсию T C 
; и температура по Фаренгейту T F связаны следующим соотношением:
; T C = (T F – 32)·5/9.
; Вывод:
; TF = 80, TC = 26.6667
extern  printf
section .data
        TF      dq      80.0
        strFormat       db      "TF = %g, TC = %g",10,0
section .bss
        TC      resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        movsd   xmm0, [TF]
        mov     rax, 32
        cvtsi2sd xmm1, rax
        subsd   xmm0, xmm1      ; TF-32
        mov     rax, 5
        cvtsi2sd xmm1, rax
        mulsd   xmm0, xmm1      ; *5
        mov     rax, 9
        cvtsi2sd xmm1, rax
        divsd   xmm0, xmm1      ; /9
        movsd   [TC], xmm0
                
        ; выводим
        mov     rdi, strFormat
        movsd   xmm0, [TF]
        movsd   xmm1, [TC]
        mov     rax, 2          ; кол-во вещественных чисел
        call    printf
        
        leave
        ret
