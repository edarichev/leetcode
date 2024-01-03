; Proc6 . Описать процедуру DigitCountSum( K , C , S ), находящую количество C
; цифр целого положительного числа K , а также их сумму S ( K — входной,
; C и S — выходные параметры целого типа). С помощью этой процедуры
; найти количество и сумму цифр для каждого из пяти данных целых чисел.
;
; Вывод:
; 123: C=3, S=6
; 2345: C=4, S=14
; 123456789: C=9, S=45

extern  printf

%macro  call_DigitCountSum 1
        mov     rdi, [%1]
        call    DigitCountSum
%endmacro

%macro  print_reg 0
        mov     rax, 0
        mov     rdi, strFormat
        call    printf
%endmacro

section .data
        A               dq      123
        B               dq      2345
        C               dq      123456789
        strFormat       db      "%d: C=%d, S=%d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        call_DigitCountSum   A
        print_reg
        call_DigitCountSum   B
        print_reg
        call_DigitCountSum   C
        print_reg
        
        
        leave
        ret

DigitCountSum:
        ; DigitCountSum
        ; Вход: rdi - число, int64
        ; Выход: rsi то же число
        ;        rdx кол-во цифр
        ;        rcx  сумма
        ; В вызываемой функции сохраняются регистры rbx, rbp, rsp, r12-r15
        push    rbp
        mov     rbp, rsp
        
        mov     rax, rdi
        xor     rcx, rcx                ; число цифр
        mov     rbx, 10
        mov     rsi, 0
        .loop_i:
                test    rax, rax
                jz      .break_i
                cdq
                idiv    rbx 
                add     rsi, rdx        ; добавить к сумме очередной остаток
                inc     rcx
                jmp     .loop_i
        .break_i:
        mov     rdx, rsi
        xchg    rdx, rcx
        mov     rsi, rdi
        leave
        ret
