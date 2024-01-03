; Proc50 . Описать процедуру TimeToHMS( T , H , M , S ), определяющую по времени
; T (в секундах) содержащееся в нем количество часов H , минут M и 
; секунд S ( T — входной, H , M и S — выходные параметры целого типа). 
; Используя эту процедуру, найти количество часов, минут и секунд для пяти
; данных отрезков времени T 1 , T 2 , ..., T 5 .
;
; Вывод:
; 01:00:00
; 01:02:36
; 24:00:00
; 05:26:37
; 15:14:12

extern  printf
%macro  CALL_TIME 1
        mov     rdi, [%1]
        mov     rsi, H
        mov     rdx, M
        mov     rcx, S
        call    TimeToHMS
        
        mov     rdi, strFormat
        mov     rsi, [H]
        mov     rdx, [M]
        mov     rcx, [S]
        call    printf
%endmacro
section .data
        T1              dq      3600
        T2              dq      3756
        T3              dq      86400
        T4              dq      19597
        T5              dq      54852
        strFormat       db      "%02d:%02d:%02d",10,0
section .bss
        H               resq    1
        M               resq    1
        S               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; вероятно, имеется в виду прошедшее время, например, такое: 123:45:15, где минуты и секунды - от 0 до 59, а часы - сколь угодно
        CALL_TIME       T1
        CALL_TIME       T2
        CALL_TIME       T3
        CALL_TIME       T4
        CALL_TIME       T5
exit:
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TimeToHMS:
        ; Вход: rdi - T
        ;       rsi - адрес переменной для часов, out
        ;       rdx - адрес переменной для минут, out
        ;       rcx - адрес переменной для секунд, out
        push    rbp
        mov     rbp, rsp

        mov     r10, rdx        ; сохраним адрес минут, т.к. rdx нужен в делении
        mov     r8, 60
        mov     rax, rdi
        cdq
        idiv    r8
        mov     [rcx], rdx      ; секунды, rax == минуты
        cdq
        idiv    r8
        mov     [r10], rdx      ; минуты, rax == часы
        mov     [rsi], rax
        
        leave
        ret
