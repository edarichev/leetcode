; Case14 . Элементы равностороннего треугольника пронумерованы следующим
; образом: 
; 1 — сторона a , 
; 2 — радиус R 1 вписанной окружности ( R 1 =  a SQRT(3) / 6 ), 
; 3 — радиус R 2 описанной окружности ( R 2 = 2· R 1 ), 
; 4 — площадь S = a^2 SQRT(3) / 4 . Дан номер одного из этих элементов и его значение. Вывести
; значения остальных элементов данного треугольника (в том же порядке).
;
; Вывод:
; 4 -> A=3, R1=0.866025, R2=1.73205, S=3.89711
extern  printf
section .data
        N               dq      4
        SQRT3           dq      1.732050808
        A               dq      3.0
        R1              dq      0.866025404
        R2              dq      1.732050808
        S               dq      3.897114317
        
        strFormat       db      "%d -> A=%g, R1=%g, R2=%g, S=%g",10,0
        strError        db      "Не поддерживается",10,0        
        labels          dq      case_A,case_R1,case_R2,case_S,case_default
section .bss
        A1              resq    1
        R1_1            resq    1
        R2_1            resq    1
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
        ; теперь константы - разнесём их по одноимённым регистрам
        mov     rbx, 2
        cvtsi2sd xmm2, rbx              ; xmm2 == 2
        movsd   xmm3, [SQRT3]           ; xmm3 == SQRT(3)
        movsd   xmm4, xmm2              ; в xmm2 лежит 2
        addsd   xmm4, xmm4              ; воспользуемся этим: xmm4 ==4
        movsd   xmm6, xmm4
        addsd   xmm6, xmm2              ; xmm6 == 6
        lea     rcx, labels
        jmp     [rcx + rax * 8 - 8]
case_A:
        movsd   xmm0, [A]
        movsd   [A1], xmm0
        movsd   xmm1, xmm0
        ; R 1 =  a SQRT(3) / 6
        mulsd   xmm0, xmm3
        divsd   xmm0, xmm6
        movsd   [R1_1], xmm0
        ; R 2 = 2· R 1
        mulsd   xmm0, xmm2
        movsd   [R2_1], xmm0
        ; S = a^2 SQRT(3) / 4
        mulsd   xmm1, xmm1
        mulsd   xmm1, xmm3
        divsd   xmm1, xmm4
        movsd   [S1], xmm1
        jmp     done
case_R1:
        ; R 1 =  a SQRT(3) / 6
        movsd   xmm0, [R1]
        movsd   [R1_1], xmm0
        movsd   xmm1, xmm0
        ; R 2 = 2· R 1
        mulsd   xmm0, xmm2
        movsd   [R2_1], xmm0
        ; A = 6 R1/SQRT(3)
        movsd   xmm0, xmm1
        mulsd   xmm0, xmm6
        divsd   xmm0, xmm3
        movsd   [A1], xmm0
        ; S = a^2 SQRT(3) / 4
        mulsd   xmm0, xmm0
        mulsd   xmm0, xmm3
        divsd   xmm0, xmm4
        movsd   [S1], xmm0
        jmp     done
case_R2:
        movsd   xmm0, [R2]
        movsd   [R2_1], xmm0
        ; R 2 = 2· R 1
        divsd   xmm0, xmm2
        movsd   [R1_1], xmm0
        movsd   xmm1, xmm0
        ; A = 6 R1/SQRT(3)
        movsd   xmm0, xmm1
        mulsd   xmm0, xmm6
        divsd   xmm0, xmm3
        movsd   [A1], xmm0
        ; S = a^2 SQRT(3) / 4
        mulsd   xmm0, xmm0
        mulsd   xmm0, xmm3
        divsd   xmm0, xmm4
        movsd   [S1], xmm0
        jmp     done
case_S:
        movsd   xmm0, [S]
        movsd   [S1], xmm0
        ; S = a^2 SQRT(3) / 4 -> A = SQRT(4S/SQRT(3))
        mulsd   xmm0, xmm4
        divsd   xmm0, xmm3
        sqrtsd  xmm0, xmm0
        movsd   [A1], xmm0
        movsd   xmm1, xmm0
        ; R 1 =  a SQRT(3) / 6
        mulsd   xmm0, xmm3
        divsd   xmm0, xmm6
        movsd   [R1_1], xmm0
        ; R 2 = 2· R 1
        mulsd   xmm0, xmm2
        movsd   [R2_1], xmm0
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
        movsd   xmm1, [R1_1]
        movsd   xmm2, [R2_1]
        movsd   xmm3, [S1]
        call    printf
exit:
        leave
        ret
