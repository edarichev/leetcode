; Case7 . Единицы массы пронумерованы следующим образом: 1 — килограмм,
; 2 — миллиграмм, 3 — грамм, 4 — тонна, 5 — центнер. Дан номер единицы
; массы (целое число в диапазоне 1–5) и масса тела в этих единицах (вещественное число). Найти массу тела в килограммах.
;
; Вывод:
; 10 кг -> 10 кг
; 10 мг -> 1e-05 кг
; 10 г -> 0.01 кг
; 10 т -> 10000 кг
; 10 ц -> 1000 кг

extern  printf
section .data
        A               dq      10.0
        X               dq      5
        sKG             dd      "кг",0
        sMG             dd      "мг",0
        sG              dd      "г",0
        sT              dd      "т",0
        sZ              dd      "ц",0
        strFormat       db      "%g %s -> %g кг",10,0
        strError        db      "Не поддерживается",10,0
        ; адреса меток для более эффективного switch/case
        labels          dq      case_kg,case_mg,case_g,case_t,case_z
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
        ; сначала операнд
        movsd   xmm0, [A]
        ; теперь метки - по порядку, поэтому просто вычислим смещение
        lea     rcx, labels
        jmp     [rcx + rax * 8 - 8]
        ; результаты поместим в xmm0
case_kg:
        mov     rsi, sKG
        ; xmm0 не меняется
        jmp     done
case_mg:
        mov     rsi, sMG
        mov     rax, 1000000
        cvtsi2sd xmm1, rax
        divsd   xmm0, xmm1
        jmp     done
case_g:
        mov     rsi, sG
        mov     rax, 1000
        cvtsi2sd xmm1, rax
        divsd   xmm0, xmm1
        jmp     done
case_t:
        mov     rsi, sT
        mov     rax, 1000
        cvtsi2sd xmm1, rax
        mulsd   xmm0, xmm1
        jmp     done
case_z:
        mov     rsi, sZ
        mov     rax, 100
        cvtsi2sd xmm1, rax
        mulsd   xmm0, xmm1
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
