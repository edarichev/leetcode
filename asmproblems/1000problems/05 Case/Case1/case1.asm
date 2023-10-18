; Case1 . Дано целое число в диапазоне 1–7. Вывести строку — название дня недели, 
; соответствующее данному числу (1 — «понедельник», 2 — «вторник» и т. д.).
;
; Вывод:
; 3 Wednesday
extern  printf
section .data
        N               dq      3
        strFormat       db      "%d %s",10,0
        s1              db      "Monday",0
        s2              db      "Tuesday",0
        s3              db      "Wednesday",0
        s4              db      "Thursday",0
        s5              db      "Friday",0
        s6              db      "Saturday",0
        s7              db      "Sunday",0
        sError          db      "Error",0
        ; адреса меток для более эффективного switch/case
        labels          dq      case_1,case_2,case_3,case_4,case_5,case_6,case_7,case_default
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; задача на switch/case, хотя можно было бы поместить строки в массив и выбрать быстрее
        mov     rax, [N]
        cmp     rax, 1
        jb      case_default
        cmp     rax, 7
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
case_6:
        mov     rdx, s6;
        jmp     done
case_7:
        mov     rdx, s7;
        jmp     done
case_default:
        mov     rdx, sError
done:
        mov     rax, 0          ; кол-во вещественных чисел
        mov     rdi, strFormat
        mov     rsi, [N]
        call    printf
        
        leave
        ret
