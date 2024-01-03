; Integer30 . Дан номер некоторого года (целое положительное число). 
; Определить соответствующий ему номер столетия, учитывая, что, к примеру,
; началом 20 столетия был 1901 год.
;
; Вывод:
; 2001 -> 21
; 2000 -> 20
extern  printf
section .data
        Year            equ     2000
        strFormat       db      "Year = %d, Century = %d",10,0
section .bss
        Century resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; убрать десятки
        mov     ax, Year
        cwd
        mov     bx, 100
        idiv    bx
        
        cmp     dx, 0
        jz      next            ; если 0, то год относится ещё к предыдущему столетию
        inc     ax              ; а если не 0, то столетие на 1 больше
next:
        movsx   rdx, ax
        ; вывод
        mov     rdi, strFormat
        mov     rsi, Year
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
