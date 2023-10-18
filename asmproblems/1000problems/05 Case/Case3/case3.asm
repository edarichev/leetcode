; Case3 . Дан номер месяца — целое число в диапазоне 1–12 (1 — январь, 2 —
; февраль и т. д.). Вывести название соответствующего времени года («зима», «весна», «лето», «осень»).
;
; Вывод:
; 6 «лето»
extern  printf
section .data
        K               dq      6
        strFormat       db      "%d %s",10,0
        s1              db      "«зима»",0
        s2              db      "«весна»",0
        s3              db      "«лето»",0
        s4              db      "«осень»",0
        sError          db      "«ошибка».",0
        ; адреса меток для более эффективного switch/case
        labels          dq      case_1,case_2,case_3,case_4,case_5,case_6
                        dq      case_7,case_8,case_9,case_10,case_11,case_12,
                        dq      case_default
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; задача на switch/case, хотя можно было бы поместить строки в массив и выбрать быстрее
        mov     rax, [K]
        cmp     rax, 1
        jb      case_default
        cmp     rax, 12
        ja      case_default
        lea     rcx, labels
        ; здесь числа идут последовательно, поэтому достаточно вычислить адрес перехода:
        ; rcx - начало таблицы меток == case_1
        ; rax * 8 - 8 --- начало с 1, а не с 0, поэтому 1*8=8, надо вычесть 8, чтобы получить смещение 0, т.е. case_1.
        jmp     [rcx + rax*8 - 8]
case_12:
case_1:
case_2:
        mov     rdx, s1;
        jmp     done
case_3:
case_4:
case_5:
        mov     rdx, s2;
        jmp     done
case_6:
case_7:
case_8:
        mov     rdx, s3;
        jmp     done
case_9:
case_10:
case_11:
        mov     rdx, s4;
        jmp     done
case_default:
        mov     rdx, sError
done:
        mov     rax, 0          ; кол-во вещественных чисел
        mov     rdi, strFormat
        mov     rsi, [K]
        call    printf
        
        leave
        ret
