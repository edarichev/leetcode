; Case2 . Дано целое число K . Вывести строку-описание оценки, соответствующей 
; числу K (1 — «плохо», 2 — «неудовлетворительно», 3 — «удовлетворительно», 4 — «хорошо», 5 — «отлично»). Если K не лежит в диапазоне
; 1–5, то вывести строку «ошибка».
;
; Вывод:
; 3 «удовлетворительно»
extern  printf
section .data
        K               dq      3
        strFormat       db      "%d %s",10,0
        s1              db      "«плохо»",0
        s2              db      "«неудовлетворительно»",0
        s3              db      "«удовлетворительно»",0
        s4              db      "«хорошо»",0
        s5              db      "«отлично»",0
        sError          db      "«ошибка».",0
        ; адреса меток для более эффективного switch/case
        labels          dq      case_1,case_2,case_3,case_4,case_5,case_default
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
        cmp     rax, 5
        ja      case_default
        lea     rcx, labels
        ; здесь числа идут последовательно, поэтому достаточно вычислить адрес перехода:
        ; rcx - начало таблицы меток == case_1
        ; rax * 8 - 8 --- начало с 1, а не с 0, поэтому 1*8=8, надо вычесть 8, чтобы получить смещение 0, т.е. case_1.
        jmp     [rcx + rax*8 - 8]
case_1:
        mov     rdx, s1;
        jmp     done
case_2:
        mov     rdx, s2;
        jmp     done
case_3:
        mov     rdx, s3;
        jmp     done
case_4:
        mov     rdx, s4;
        jmp     done
case_5:
        mov     rdx, s5;
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
