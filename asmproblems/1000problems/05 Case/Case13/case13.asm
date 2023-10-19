; Case13 . Элементы равнобедренного прямоугольного треугольника пронумерованы следующим образом: 
; 1 — катет a , 2 — гипотенуза c = a SQRT(2) , 
; 3 — высота h , опущенная на гипотенузу ( h = c /2), 4 — площадь S = c · h /2. 
; Дан номер одного из этих элементов и его значение. Вывести значения остальных
; элементов данного треугольника (в том же порядке).
;
; Вывод:
; 2 -> A=3, C=4.24264, H=2.12132, S=4.5
extern  printf
section .data
        N               dq      4
        SQRT2           dq      1.414213562
        A               dq      3.0
        C               dq      4.242640687
        H               dq      2.121320344
        S               dq      4.5
        
        strFormat       db      "%d -> A=%g, C=%g, H=%g, S=%g",10,0
        strError        db      "Не поддерживается",10,0        
        labels          dq      case_A,case_C,case_H,case_S,case_default
section .bss
        A1              resq    1
        C1              resq    1
        H1              resq    1
        S1              resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rax, [N]
        cmp     rax, 1
        jb      case_default
        cmp     rax, 4
        ja      case_default
        mov     rbx, 2
        cvtsi2sd xmm3, rbx              ; xmm3 == 2
        movsd   xmm2, [SQRT2]           ; xmm2 == SQRT(2)
        lea     rcx, labels
        jmp     [rcx + rax * 8 - 8]
case_A:
        ; как есть, за основу A
        movsd   xmm0, [A]
        movsd   [A1], xmm0
        mulsd   xmm0, xmm2              ; C = A * sqrt 2
        movsd   [C1], xmm0
        movsd   xmm1, xmm0              ; далее нужно C
        divsd   xmm0, xmm3              ; H=C/2
        movsd   [H1], xmm0
        divsd   xmm0, xmm3              ; S = c · h /2
        mulsd   xmm0, xmm1
        movsd   [S1], xmm0
        jmp     done
case_C:
        ; c = a SQRT(2) -> A=C/SQRT(2)
        movsd   xmm0, [C]
        movsd   [C1], xmm0
        movsd   xmm1, xmm0
        divsd   xmm0, xmm2              ; / SQRT(2)
        movsd   [A1], xmm0
        movsd   xmm0, xmm1
        divsd   xmm0, xmm3              ; H=C/2
        movsd   [H1], xmm0
        divsd   xmm0, xmm3              ; S = c · h /2
        mulsd   xmm0, xmm1
        movsd   [S1], xmm0
        jmp     done
case_H:
        ; h = c / 2 -> C = 2*h
        movsd   xmm0, [H]
        movsd   [H1], xmm0
        movsd   xmm4, xmm0              ; сохр. H
        mulsd   xmm0, xmm3              ; H*2 -> C
        movsd   [C1], xmm0
        movsd   xmm1, xmm0              ; сохр. C
        divsd   xmm0, xmm2              ; A=C/SQRT(2)
        movsd   [A1], xmm0
        movsd   xmm0, xmm1              ; S = c · h /2
        mulsd   xmm0, xmm4
        divsd   xmm0, xmm3
        movsd   [S1], xmm0
        jmp     done
case_S:
        ; S = c · h /2, h = c /2 => S=2H*H/2=H^2 => H=SQRT(S)
        movsd   xmm0, [S]
        movsd   [S1], xmm0
        sqrtsd  xmm0, xmm0
        movsd   [H1], xmm0
        mulsd   xmm0, xmm3              ; H*2 -> C
        movsd   [C1], xmm0
        movsd   xmm1, xmm0              ; сохр. C
        divsd   xmm0, xmm2              ; A=C/SQRT(2)
        movsd   [A1], xmm0
        jmp     done
case_default:
        mov     rdi, strError
        call    printf
        jmp     exit
done:
        mov     rax, 4          ; 4 Вещественных
        mov     rdi, strFormat
        mov     rsi, [N]
        movsd   xmm0, [A1]
        movsd   xmm1, [C1]
        movsd   xmm2, [H1]
        movsd   xmm3, [S1]
        call    printf
exit:
        leave
        ret
