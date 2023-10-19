; Case16 . Дано целое число в диапазоне 20–69, определяющее возраст (в годах).
; Вывести строку-описание указанного возраста, обеспечив правильное 
; согласование числа со словом «год», например: 20 — «двадцать лет», 32 —
; «тридцать два года», 41 — «сорок один год».
;
; Вывод:
; семь лет
; один год
; девятнадцать лет
; сорок один год
; двадцать шесть лет
extern  printf
section .data
        N               dq      26
        
        s_1             db      "один",0
        s_2             db      "два",0
        s_3             db      "три",0
        s_4             db      "четыре",0
        s_5             db      "пять",0
        s_6             db      "шесть",0
        s_7             db      "семь",0
        s_8             db      "восемь",0
        s_9             db      "девять",0
        
        s_10            db      "десять",0
        s_11            db      "одиннадцать",0
        s_12            db      "двенадцать",0
        s_13            db      "тринадцать",0
        s_14            db      "четырнадцать",0
        s_15            db      "пятнадцать",0
        s_16            db      "шестнадцать",0
        s_17            db      "семнадцать",0
        s_18            db      "восемнадцать",0
        s_19            db      "девятнадцать",0
        labe1s_19       dq      s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10
                        dq      s_11, s_12, s_13, s_14, s_15, s_16, s_17, s_18, s_19
        
        s_20            db      "двадцать",0
        s_30            db      "тридцать",0
        s_40            db      "сорок",0
        s_50            db      "пятьдесят",0
        s_60            db      "шестьдесят",0
        labels_round_10 dq      s_20, s_30, s_40, s_50, s_60
        s_year1         db      "год",0
        s_year234       db      "года",0
        s_years         db      "лет",0
        
        strFormat2      db      "%s %s",10,0
        strFormat3      db      "%s %s %s",10,0
        strError        db      "Не поддерживается",10,0
        
        
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rax, [N]
        cmp     rax, 1
        jb      case_default
        je      case_year_1
        cmp     rax, 69
        ja      case_default
        mov     rcx, rax
        mov     rbx, 10
        cdq
        idiv    rbx
        mov     rbx, rax
        mov     rax, rcx
        ; год, года, лет
        cmp     rbx, 1          ; 11 <= N <= 19
        je      case_years
        cmp     rdx, 0          ; в любом случае
        je      case_years
        cmp     rdx, 1          ; 1 год
        je      case_year_1
        cmp     rdx, 5          ; 2..4 года
        jl      case_year_2_4
        jmp     case_years
        ; в rdx потом занесём "год, года, лет", пока это в r9
case_year_1:
        mov     r9, s_year1
        jmp     checkNumber
case_year_2_4:
        mov     r9, s_year234
        jmp     checkNumber
case_years:
        mov     r9, s_years
        jmp     checkNumber
checkNumber:
        cmp     rax, 19
        jg      may_be_three_words
        ; здесь точно формат - два слова - 1-19
        mov     rdi, strFormat2
        lea     rsi, labe1s_19                  ; числительное
        mov     rsi, [rsi + rax * 8 - 8]
        mov     rdx, r9         ; "год, года, лет"
        jmp     done
may_be_three_words:
        ; здесь может быть и три слова
        mov     rbx, 10
        cdq
        idiv    rbx
        ; в rax остались десятки, они начинаются с 2, т.к. 1 в отдельном массиве
        dec     rax
        dec     rax
        lea     rsi, labels_round_10
        mov     rsi, [rsi + rax * 8]
        cmp     rdx, 0
        je      round_10        ; идём на два слова
        ; три слова, в rdx сейчас единицы как остаток от деления на 10, поместим их как строку в rcx
        mov     rdi, strFormat3
        lea     rcx, labe1s_19
        mov     rdx, [rcx + rdx * 8 - 8]
        mov     rcx, r9         ; "год, года, лет"
        jmp     done
round_10:
        mov     rdi, strFormat2
        mov     rdx, r9         ; "год, года, лет"
        jmp     done
case_default:
        mov     rdi, strError
        call    printf
        jmp     exit
done:
        mov     rax, 0          ; 0 Вещественных
        call    printf
exit:
        leave
        ret
