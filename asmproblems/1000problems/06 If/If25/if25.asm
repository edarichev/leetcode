; If25 . Для данного целого x найти значение следующей функции f , принимающей значения целого типа:
;               2· x , если x < –2 или x > 2,
; f ( x ) =
;               –3· x , в противном случае.
;
; Вывод:
; x=3, f=6
; x=1, f=-3
; x=-5, f=-10
extern  printf

section .data
        x               dq      3
        strFormat       db      "x=%d, f=%d",10,0
section .bss
        f               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rax, [x]
        cmp     rax, -2
        jl      to2x
        cmp     rax, 2
        jg      to2x
        imul    rax, -3
        jmp     done
to2x:
        imul    rax, 2
done:
        mov     [f], rax
        ; выводим
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, [x]
        mov     rdx, [f]
        call    printf
        leave
        ret
