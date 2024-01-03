; f30 . Дано целое число, лежащее в диапазоне 1–999. Вывести его строку-
; описание вида «четное двузначное число», «нечетное трехзначное число»
; и т. д.
;
; Вывод:
; 1, N1, odd
; 2, N1, even
; 22, N2, even
; 123, N3, odd
extern  printf

section .data
        N               dw      999
        strFormat       db      "%d, N%d, %s",10,0
        strEven         db      "even",0
        strOdd          db      "odd"
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     ax, [N]
        test    ax, 1
        jz      even
        mov     rcx, strOdd
        jmp     checkCount
even:
        mov     rcx, strEven
        jmp     checkCount
checkCount:
        mov     r8, 1           ; кол-во цифр
        cwd                     ; [ax] ещё тот же                     
        mov     bx, 10
        idiv    bx
        test    ax, ax
        jz      done            ; цифр  нет
        inc     r8
        cwd
        idiv    bx
        test    ax, ax
        jz      done            ; цифр  нет
        inc     r8
        cwd
        idiv    bx
        test    ax, ax
        jz      done            ; цифр  нет
        inc     r8
done:
        mov     rdx, r8
        ; выводим
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        movsx   rsi, word [N]
        ; rdx - кол-во цифр
        ; rcx - even, odd
        call    printf
        leave
        ret
