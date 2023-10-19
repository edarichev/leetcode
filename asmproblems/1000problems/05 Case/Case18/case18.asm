; Case18 . Дано целое число в диапазоне 100–999. Вывести строку-описание
; данного числа, например: 256 — «двести пятьдесят шесть», 814 — «восемьсот четырнадцать».
;
; Вывод:
; девятнадцать
; пятьсот двадцать один
; пятьсот четыре
; девятьсот девятнадцать
extern  printf
extern  strcat
section .data
        N               dq      91
        
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
        s_70            db      "семьдесят",0
        s_80            db      "восемьдесят",0
        s_90            db      "девяносто",0
        labels_round_10 dq      s_20, s_30, s_40, s_50, s_60,s_70,s_80,s_90
        
        s_100           db      "сто",0
        s_200           db      "двести",0
        s_300           db      "триста",0
        s_400           db      "четыреста",0
        s_500           db      "пятьсот",0
        s_600           db      "шестьсот",0
        s_700           db      "семьсот",0
        s_800           db      "восемьсот",0
        s_900           db      "девятьсот",0
        labels_hundred  dq      s_100, s_200, s_300, s_400, s_500, s_600, s_700, s_800, s_900
        
        strFormat1      db      "%s",10,0
        strFormat2      db      "%s %s",10,0
        strFormat3      db      "%s %s %s",10,0
        sFormats        dq      strFormat1, strFormat2, strFormat3
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
        cmp     rax, 999
        ja      case_default
        ; r8 - сотни, r9 - десятки, r10 - единицы
        cdq
        mov     rbx, 10
        idiv    rbx
        mov     r10, rdx         ; единицы
        cdq
        idiv    rbx
        mov     r9, rdx          ; десятки
        cdq
        idiv    rbx
        mov     r8, rdx          ; сотни

check100:
        test    r8, r8
        jnz     case_100
check10:
        test    r9, r9
        jnz     case_10
        jmp     case_1
case_100:
        ; есть сотни
        lea     rsi, labels_hundred
        mov     rsi, [rsi + r8 * 8 - 8]        ; начало с 1 -> -8
        mov     r8, rsi                        ; сохраним теперь тут адрес строки сотен
        jmp     case_10
case_10:
        cmp     r9, 1
        je      try_case_19
        test    r9, r9
        jz      case_1
        lea     rsi, labels_round_10
        mov     rsi, [rsi + r9 * 8 - 16]
        mov     r9, rsi
        jmp     case_1
try_case_19:
        mov     rax, 10
        add     rax, r10
        jmp     case_19
case_1:
        test    r10, r10
        jz      done
        lea     rsi, labe1s_19
        mov     rsi, [rsi + r10 * 8 - 8]
        mov     r10, rsi
        jmp     done
case_19:
        lea     rsi, labe1s_19
        mov     rsi, [rsi + rax * 8 - 8]
        mov     r9, rsi
        mov     r10, 0
        jmp     done
case_default:
        mov     rdi, strError
        call    printf
        jmp     exit
done:
        mov     rax, 0          ; 0 Вещественных
        mov     r12, 0          ; посчитаем, сколько аргументов
        test    r8, r8
        jz      check_r9
        push    r8
        inc     r12
check_r9:
        test    r9, r9
        jz      check_r10
        push    r9
        inc     r12
check_r10:
        test    r10, r10
        jz      set_format
        push    r10
        inc     r12
set_format:
        lea     rdi, sFormats
        mov     rdi, [rdi + r12 * 8 - 8]
print:
        cmp     r12, 1
        je      set_1
        cmp     r12, 2
        je      set_2
        pop     rcx
        pop     rdx
        pop     rsi
        jmp     out
set_1:
        pop     rsi
        jmp     out
set_2:
        pop     rdx
        pop     rsi
        jmp     out
out:
        call    printf
exit:
        leave
        ret
