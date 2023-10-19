; Case20 . Даны два целых числа: D (день) и M (месяц), определяющие правильную дату. 
; Вывести знак Зодиака, соответствующий этой дате: «Водолей»
; (20.1–18.2), «Рыбы» (19.2–20.3), «Овен» (21.3–19.4), «Телец» (20.4–20.5),
; «Близнецы» (21.5–21.6), «Рак» (22.6–22.7), «Лев» (23.7–22.8), «Дева»
; (23.8–22.9), «Весы» (23.9–22.10), «Скорпион» (23.10–22.11), «Стрелец»
; (23.11–21.12), «Козерог» (22.12–19.1).
;
; Вывод:
; 19.10: Весы
; 22.12: Козерог
extern  printf
extern  strcat
section .data
        D               dq      21
        M               dq      12
        
        s_1             db      "Овен",0
        s_2             db      "Телец",0
        s_3             db      "Близнецы",0
        s_4             db      "Рак",0
        s_5             db      "Лев",0
        s_6             db      "Дева",0
        s_7             db      "Весы",0
        s_8             db      "Скорпион",0
        s_9             db      "Стрелец",0
        s_10            db      "Козерог",0
        s_11            db      "Рыбы",0
        s_12            db      "Водолей",0
        strFormat       db      "%02d.%02d: %s",10,0      ; 01.02: Водолей
        strError        db      "Не поддерживается",10,0
        
        daysToMonth365  dq      0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365
        ; первый знак - козерог, он и в конце года, поэтому 13
        daysToSign365   dq      0, 20, 50, 80, 110, 141, 173, 204, 235, 266, 296, 327, 356, 367 ; должно превышать
        signNames       dq      s_10, s_11, s_12, s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10 ; козерог,...,козерог
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rax, [M]
        mov     rbx, [D]
        ; считаем, что год невисокосный, кроме того, вход в знак технически не всегда точно выпадает на этот день
        ; определим номер дня года
        lea     rcx, daysToMonth365
        mov     rcx, [rcx + rax * 8 - 8]
        add     rcx, rbx        ; номер дня года здесь
        ; теперь переберём daysToSign365, если найдётся превышение, то это и будет № знака
        mov     rax, rcx
        xor     rcx, rcx        ; счётчик - номер знака в signNames/daysToSign365
        lea     rbx, [daysToSign365 + 8]
next_check:
        mov     rdx, qword [rbx]
        cmp     rdx, rax
        jg      break1
        add     rbx, 8
        inc     rcx
        jmp     next_check
break1:
        ; теперь в rcx номер знака
        jmp     done
notsupported:
        mov     rdi, strError
        call    printf
        jmp     exit
done:
        ; вывод
        mov     rdi, strFormat
        mov     rsi, [D]
        mov     rdx, [M]
        lea     rbx, signNames
        mov     rcx, [rbx + rcx * 8]
        mov     rax, 0
        call    printf
exit:
        leave
        ret
