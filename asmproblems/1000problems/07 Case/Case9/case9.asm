; Case9 ° . Даны два целых числа: D (день) и M (месяц), определяющие правильную 
; дату невисокосного года. Вывести значения D и M для даты, следующей за указанной.
;
; Вывод:
; 01.01 -> 02.01
; 31.12 -> 01.01
extern  printf
section .data
        D               dq      30
        M               dq      7
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
        ; увеличим день, но число <=0 сменим в case-блоках на 28,30 или 31
        mov     rbx, [D]
        inc     rbx
        cmp     rbx, 28
        jng     done            ; перехода в предыдущий месяц нет, сразу на вывод даты
        ; возможен переход в следущий месяц (в rbx м.б. 29,30,31,32)
        ; метки - по порядку, поэтому просто вычислим смещение
        lea     rcx, labels
        jmp     [rcx + rax * 8 - 8]
        jmp     done
case_1:
        cmp     rbx, 31
        jng     done
        mov     rax, 2
        mov     rbx, 1
        jmp     done
case_2:
        cmp     rbx, 28
        jng     done
        mov     rax, 3
        mov     rbx, 1
        jmp     done
case_3:
        cmp     rbx, 31
        jng     done
        mov     rax, 4
        mov     rbx, 1
        jmp     done
case_4:
        cmp     rbx, 30
        jng     done
        mov     rax, 5
        mov     rbx, 1
        jmp     done
case_5:
        cmp     rbx, 31
        jng     done
        mov     rax, 6
        mov     rbx, 1
        jmp     done
case_6:
        cmp     rbx, 30
        jng     done
        mov     rax, 7
        mov     rbx, 1
        jmp     done
case_7:
        cmp     rbx, 31
        jng     done
        mov     rax, 8
        mov     rbx, 1
        jmp     done
case_8:
        cmp     rbx, 31
        jng     done
        mov     rax, 9
        mov     rbx, 1
        jmp     done
case_9:
        cmp     rbx, 30
        jng     done
        mov     rax, 10
        mov     rbx, 1
        jmp     done
case_10:
        cmp     rbx, 31
        jng     done
        mov     rax, 11
        mov     rbx, 1
        jmp     done
case_11:
        cmp     rbx, 30
        jng     done
        mov     rax, 12
        mov     rbx, 1
        jmp     done
case_12:
        cmp     rbx, 31
        jng     done
        mov     rax, 1
        mov     rbx, 1
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
