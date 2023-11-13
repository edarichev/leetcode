; Proc51 . Описать процедуру IncTime( H , M , S , T ), которая увеличивает на T 
; секунд время, заданное в часах H , минутах M и секундах S ( H , M и S — 
; входные и выходные параметры, T — входной параметр; все параметры — целые 
; положительные). Дано время (в часах H , минутах M , секундах S ) и 
; целое число T . Используя процедуру IncTime, увеличить данное время на T
; секунд и вывести новые значения H , M , S .
;
; Вывод:
; 03:15:08
; 03:17:46

extern  printf

section .data
        H               dq      3
        M               dq      15
        S               dq      8
        T               dq      158
        strFormat       db      "%02d:%02d:%02d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rdi, strFormat
        mov     rsi, [H]
        mov     rdx, [M]
        mov     rcx, [S]
        call    printf

        mov     rdi, H
        mov     rsi, M
        mov     rdx, S
        mov     rcx, [T]
        call    IncTime
        
        mov     rdi, strFormat
        mov     rsi, [H]
        mov     rdx, [M]
        mov     rcx, [S]
        call    printf
exit:
        leave
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IncTime:
        ; Вход: rdi - H, адрес, in, out
        ;       rsi - M, адрес, in, out
        ;       rdx - S, адрес, in, out
        ;       rcx - T, значение, in
        ; 
        push    rbp
        mov     rbp, rsp

        ; сначала перевести в секунды
        
        mov     rax, qword [rdi]
        imul    rax, 60
        add     rax, [rsi]
        imul    rax, 60
        add     rax, [rdx]
        
        add     rax, rcx        ; +T
        
        mov     rcx, rdx
        mov     rdx, rsi
        mov     rsi, rdi
        mov     rdi, rax
        call    TimeToHMS
        
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
