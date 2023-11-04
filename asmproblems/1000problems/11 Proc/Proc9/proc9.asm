; Proc9 . Описать процедуру AddLeftDigit( D , K ), добавляющую к целому положительному 
; числу K слева цифру D ( D — входной параметр целого типа, лежащий 
; в диапазоне 1–9, K — параметр целого типа, являющийся одновременно 
; входным и выходным). С помощью этой процедуры последовательно 
; добавить к данному числу K слева данные цифры D 1 и D 2 , выводя результат каждого добавления.
;
; Вывод:
; 123, 5 -> 5321
; 5123, 6 -> 65123

extern  printf

section .data
        A               dq      123
        D1              dq      5
        D2              dq      6
        strFormat       db      "%d, %d -> %d",10,0
section .bss
        A1              resq    1       ; temp
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rax, [A]
        mov     [A1], rax
        
        mov     rdi, A1         ; адрес
        push    rax             ; сохраним предыдущее значение, чтобы вывести
        sub     rsp, 8
        mov     rsi, [D1]
        call    AddLeftDigit

        add     rsp, 8
        pop     rsi
        xor     rax, rax
        mov     rdi, strFormat
        mov     rdx, [D1]
        mov     rcx, [A1]
        call    printf
        
        mov     rdi, A1         ; адрес
        mov     rax, [rdi]
        push    rax
        sub     rsp, 8
        
        mov     rsi, [D2]
        call    AddLeftDigit

        add     rsp, 8
        pop     rsi
        xor     rax, rax
        mov     rdi, strFormat
        mov     rdx, [D2]
        mov     rcx, [A1]
        call    printf
        
        
        leave
        ret

AddLeftDigit:
        ; AddLeftDigit
        ; Вход: rdi - адрес переменной, int64
        ;       rsi - добавляемая цифра
        ; Выход: rdi, тот же адрес
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        ; здесь это число надо умножить на 10 столько раз, сколько чисел
        mov     rax, [rdi]
        mov     rcx, rsi        ; сюда перевернём
        mov     rbx, 10         ; делитель
        .loop_i:
                test    rax, rax
                jz      .break_i
                cdq
                idiv    rbx
                imul    rcx, 10
                jmp     .loop_i
        .break_i:
        add     rcx, [rdi]      ; а  теперь просто сложить
        mov     [rdi], rcx
        leave
        ret
