; Case8 . Даны два целых числа: D (день) и M (месяц), определяющие правильную 
; дату невисокосного года. Вывести значения D и M для даты, предшествующей указанной.
;
; Вывод:
; 01.01 -> 31.12
; 30.06 -> 29.06
extern  printf
section .data
        D               dq      30
        M               dq      6
        strFormat       db      "%02d.%02d -> %02d.%02d",10,0 ; dd.mm
        strError        db      "Не поддерживается",10,0
        ; адреса меток для более эффективного switch/case
        labels          dq      case_1,case_2,case_3,case_4,case_5,case_6
                        dq      case_7,case_8,case_9,case_10,case_11,case_12,
                        dq      case_default
section .bss
        D1              resq    1
        M1              resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; и здесь проще решить через массив, но тема - switch/case
        mov     rax, [M]
        ; допустимый диапазон 1-12, Месяцы
        cmp     rax, 1
        jb      case_default
        cmp     rax, 12
        ja      case_default
        ; уменьшим день, но число <=0 сменим в case-блоках на 28,30 или 31
        mov     rbx, [D]
        dec     rbx
        cmp     rbx, 1
        jnl     done            ; перехода в предыдущий месяц нет, сразу на вывод даты
        ; переход в предыдущий месяц, уменьшим на 1
        dec     rax
        cmp     rax, 1
        jnl     month_ok
        mov     rax, 12
month_ok:
        ; метки - по порядку, поэтому просто вычислим смещение
        lea     rcx, labels
        jmp     [rcx + rax * 8 - 8]
        jmp     done
case_1:
        mov     rbx, 31
        jmp     done
case_2:
        mov     rbx, 28
        jmp     done
case_3:
        mov     rbx, 31
        jmp     done
case_4:
        mov     rbx, 30
        jmp     done
case_5:
        mov     rbx, 31
        jmp     done
case_6:
        mov     rbx, 30
        jmp     done
case_7:
case_8:
        mov     rbx, 31
        jmp     done
case_9:
        mov     rbx, 30
        jmp     done
case_10:
        mov     rbx, 31
        jmp     done
case_11:
        mov     rbx, 30
        jmp     done
case_12:
        mov     rbx, 31
        jmp     done
case_default:
        mov     rdi, strError
        call    printf
        jmp     exit
done:
        mov     [D1], rbx
        mov     [M1], rax
        mov     rax, 0          ; кол-во вещественных чисел
        mov     rdi, strFormat
        mov     rsi, [D]
        mov     rdx, [M]
        mov     rcx, [D1]
        mov     r8, [M1]
        call    printf
exit:
        leave
        ret
