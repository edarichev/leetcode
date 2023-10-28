; Begin11. Даны два ненулевых числа. Найти сумму, разность, произведение и частное их модулей.
;
; Вывод:
; a=-9, b=4, |a|=9, |b|=4, (a + b)=13, (a - b)=5, (a * b)=36, (a / b)=2.25
extern  printf
section .data
        a       dq      -9.0
        b       dq      4.0
        strFormat       db      "a=%g, b=%g, |a|=%g, |b|=%g, (a + b)=%g, (a - b)=%g, (a * b)=%g, (a / b)=%g",10,0
section .bss
        a2      resq    1       ; переменная для |a|
        b2      resq    1       ; переменная для |b|
        sums    resq    1       ; сумма
        subs    resq    1       ; разность
        muls    resq    1       ; произведение
        divs    resq    1       ; частное
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; вычислим модули
        movsd   xmm0, [a]
        pslld   xmm0, 1         ; модуль: за знак отвечает первый бит, поэтому просто затерём его:
        psrld   xmm0, 1         ; сдвинем сначала влево, а затем вправо, и там будет 0
        movsd   [a2], xmm0

        movsd   xmm1, [b]
        pslld   xmm1, 1         ; модуль: за знак отвечает первый бит, поэтому просто затерём его:
        psrld   xmm1, 1         ; сдвинем сначала влево, а затем вправо, и там будет 0
        movsd   [b2], xmm1
        ; сумма
        movsd   xmm2, xmm0
        addsd   xmm2, xmm1
        movsd   [sums], xmm2
        ; разность
        movsd   xmm2, xmm0
        subsd   xmm2, xmm1
        movsd   [subs], xmm2
        ; произведение
        movsd   xmm2, xmm0
        mulsd   xmm2, xmm1
        movsd   [muls], xmm2
        ; частное
        movsd   xmm2, xmm0
        divsd   xmm2, xmm1
        movsd   [divs], xmm2

        ; выводим
        movsd   xmm0, [a]
        movsd   xmm1, [b]
        movsd   xmm2, [a2]
        movsd   xmm3, [b2]
        movsd   xmm4, [sums]
        movsd   xmm5, [subs]
        movsd   xmm6, [muls]
        movsd   xmm7, [divs]
        mov     rax, 8          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
