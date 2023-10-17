; If29 . Дано целое число. Вывести его строку-описание вида 
; «отрицательное четное число», «нулевое число», «положительное нечетное число» и т. д.
;
; Вывод:
; -1 odd negative
; -2 even negative
; 0 zero
; 1 odd positive
; 2 even positive
extern  printf

section .data
        N               dw      1
        strFormatON     db      "%d, odd negative",10,0
        strFormatOP     db      "%d, odd positive",10,0
        strFormatZero   db      "%d, zero",10,0
        strFormatEN     db      "%d, even negative",10,0
        strFormatEP     db      "%d, even positive",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        movsx   rax, word [N]
        cmp     rax, 0
        jl      negative
        jg      positive
        mov     rdi, strFormatZero
        jmp     done
positive:
        test    rax, 1
        jz      positiveEven
        mov     rdi, strFormatOP
        jmp     done
positiveEven:
        mov     rdi, strFormatEP
        jmp     done
negative:
        neg     rax
        test    rax, 1
        jz      negativeEven
        mov     rdi, strFormatON
        jmp     done
negativeEven:
        mov     rdi, strFormatEN
        jmp     done
done:
        ; выводим
        mov     rax, 0          ; кол-во вещественных
        movsx   rsi, word [N]
        call    printf
        leave
        ret
