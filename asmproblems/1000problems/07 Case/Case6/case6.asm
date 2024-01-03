; Case6 . Единицы длины пронумерованы следующим образом: 1 — дециметр,
; 2 — километр, 3 — метр, 4 — миллиметр, 5 — сантиметр. Дан номер единицы 
; длины (целое число в диапазоне 1–5) и длина отрезка в этих единицах (вещественное число). Найти длину отрезка в метрах.
;
; Вывод:
; 10 dm -> 1 m
; 10 km -> 10000 m
; 10 cm -> 0.1 m
extern  printf
section .data
        A               dq      10.0
        X               dq      5
        sDM             dd      "dm",0
        sKM             dd      "km",0
        sM              dd      "m",0
        sMM             dd      "mm",0
        sCM             dd      "cm",0
        strFormat       db      "%g %s -> %g m",10,0
        strError        db      "Не поддерживается",10,0
        ; адреса меток для более эффективного switch/case
        labels          dq      case_deci,case_kilo,case_m,case_mm,case_cm
                        dq      case_default
section .bss
        Result          resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; допустимый диапазон 1-5
        mov     rax, [X]
        cmp     rax, 1
        jb      case_default
        cmp     rax, 5
        ja      case_default
        ; сначала операнды
        movsd   xmm0, [A]
        ; теперь метки - по порядку, поэтому просто вычислим смещение
        lea     rcx, labels
        jmp     [rcx + rax * 8 - 8]
        ; результаты поместим в xmm0
case_deci:
        mov     rsi, sDM
        mov     rax, 10
        cvtsi2sd xmm1, rax
        divsd   xmm0, xmm1
        jmp     done
case_kilo:
        mov     rsi, sKM
        mov     rax, 1000
        cvtsi2sd xmm1, rax
        mulsd   xmm0, xmm1
        jmp     done
case_m:
        mov     rsi, sM
        ; xmm0 не меняется
        jmp     done
case_mm:
        mov     rsi, sMM
        mov     rax, 1000
        cvtsi2sd xmm1, rax
        divsd   xmm0, xmm1
        jmp     done
case_cm:
        mov     rsi, sCM
        mov     rax, 100
        cvtsi2sd xmm1, rax
        divsd   xmm0, xmm1
        jmp     done
case_default:
        mov     rdi, strError
        call    printf
        jmp     exit
done:
        movsd   [Result], xmm0
        mov     rax, 2          ; кол-во вещественных чисел
        mov     rdi, strFormat
        movsd   xmm0, [A]
        movsd   xmm1, [Result]
        call    printf
exit:
        leave
        ret
