; Case5 . Арифметические действия над числами пронумерованы следующим
; образом: 1 — сложение, 2 — вычитание, 3 — умножение, 4 — деление.
; Дан номер действия N (целое число в диапазоне 1–4) и вещественные 
; числа A и B ( В не равно 0). Выполнить над числами указанное действие и вывести результат.
;
; Вывод:
; 10 / 2 = 5
extern  printf
section .data
        A               dq      10.0
        B               dq      2.0
        Action          dq      5
        strFormat       db      "%g %c %g = %g",10,0
        cAdd            db      "+"
        cSub            db      "-"
        cMul            db      "*"
        cDiv            db      "/"
        strError        db      "Недопустимая операция",10,0
        ; адреса меток для более эффективного switch/case
        labels          dq      case_add,case_sub,case_mul,case_div
                        dq      case_default
section .bss
        Result          resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; диапазон
        mov     rax, [Action]
        cmp     rax, 1
        jb      case_default
        cmp     rax, 4
        ja      case_default
        ; сначала операнды
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        ; теперь метки - по порядку, поэтому просто вычислим смещение
        lea     rcx, labels
        jmp     [rcx + rax * 8 - 8]
case_add:
        mov     rsi, [cAdd]
        addsd   xmm0, xmm1
        jmp     done
case_sub:
        mov     rsi, [cSub]
        subsd   xmm0, xmm1
        jmp     done
case_mul:
        mov     rsi, [cMul]
        mulsd   xmm0, xmm1
        jmp     done
case_div:
        mov     rsi, [cDiv]
        divsd   xmm0, xmm1
        jmp     done
case_default:
        mov     rdi, strError
        call    printf
        jmp     exit
done:
        movsd   [Result], xmm0
        mov     rax, 3          ; кол-во вещественных чисел
        mov     rdi, strFormat
        ; rsi - символ действия
        movsd   xmm0, [A]
        movsd   xmm1, [B]
        movsd   xmm2, [Result]
        call    printf
exit:
        leave
        ret
