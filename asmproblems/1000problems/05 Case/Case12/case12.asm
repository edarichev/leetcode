; Case12 . Элементы окружности пронумерованы следующим образом: 
; 1 — радиус R , 2 — диаметр D = 2· R , 3 — длина L = 2· π · R , 4 — площадь круга
; S = π · R^2 . Дан номер одного из этих элементов и его значение. 
; Вывести значения остальных элементов данной окружности (в том же порядке). 
; В качестве значения π использовать 3.14.
;
; Вывод:
; 2 -> R=3, D=6, L=18.84, S=28.26
extern  printf
section .data
        N               dq      3
        PI              dq      3.14
        R               dq      3.0
        D               dq      6.0
        L               dq      18.84
        S               dq      28.26
        
        strFormat       db      "%d -> R=%g, D=%g, L=%g, S=%g",10,0
        strError        db      "Не поддерживается",10,0        
        labels          dq      case_R,case_D,case_L,case_S,case_default
section .bss
        R1              resq    1
        D1              resq    1
        L1              resq    1
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
        movsd   xmm2, [PI]
        lea     rcx, labels
        jmp     [rcx + rax * 8 - 8]
case_R:
        ; здесь просто используем R
        movsd   xmm0, [R]
        movsd   [R1], xmm0
        movsd   xmm1, xmm0      ; сохраним
        addsd   xmm0, xmm0      ; D=2R
        movsd   [D1], xmm0
        mulsd   xmm0, xmm2      ; L = 2· π · R=2R*pi=pi*D
        movsd   [L1], xmm0
        movsd   xmm0, xmm1      ; S = π · R^2
        mulsd   xmm0, xmm0
        mulsd   xmm0, xmm2
        movsd   [S1], xmm0
        jmp     done
case_D:
        ; D = 2· R --- найти R, R=D/2
        mov     rax, 2
        cvtsi2sd xmm1, rax
        movsd   xmm0, [D]
        movsd   [D1], xmm0
        movsd   xmm3, xmm0      ; D=2R, чтоб не умножать
        divsd   xmm0, xmm1      ; R=D/2
        movsd   xmm1, xmm0      ; R сохранить, ниже надо
        movsd   [R1], xmm0
        mulsd   xmm3, xmm2      ; L=2R*pi
        movsd   [L1], xmm3
        movsd   xmm0, xmm1      ; <- R
        mulsd   xmm0, xmm0      ; R^2
        mulsd   xmm0, xmm2      ; *PI
        movsd   [S1], xmm0
        jmp     done
case_L:
        ; L = 2· π · R -> R=L/2PI
        movsd   xmm0, [L]
        movsd   [L1], xmm0
        mov     rax, 2
        cvtsi2sd xmm1, rax
        divsd   xmm0, xmm1      ; /2
        divsd   xmm0, xmm2      ; /pi
        movsd   [R1], xmm0
        movsd   xmm1, xmm0      ; сохранить R
        addsd   xmm0, xmm0      ; D=2R
        movsd   [D1], xmm0
        movsd   xmm0, xmm1      ; <- R
        mulsd   xmm0, xmm0      ; R^2
        mulsd   xmm0, xmm2      ; *PI
        movsd   [S1], xmm0
        jmp     done
case_S:
        ; S = π · R^2 -> R=sqrt(S/pi)
        movsd   xmm0, [S]
        divsd   xmm0, xmm2      ; /pi
        sqrtsd  xmm0, xmm0      ; R
        movsd   [R1], xmm0
        movsd   xmm1, xmm0      ; сохранить R
        addsd   xmm0, xmm0      ; D=2R
        movsd   [D1], xmm0
        mulsd   xmm0, xmm2      ; L=2D
        movsd   [L1], xmm0
        jmp     done
case_default:
        mov     rdi, strError
        call    printf
        jmp     exit
done:
        mov     rax, 4          ; 4 Вещественных
        mov     rdi, strFormat
        mov     rsi, [N]
        movsd   xmm0, [R1]
        movsd   xmm1, [D1]
        movsd   xmm2, [L1]
        movsd   xmm3, [S1]
        call    printf
exit:
        leave
        ret
