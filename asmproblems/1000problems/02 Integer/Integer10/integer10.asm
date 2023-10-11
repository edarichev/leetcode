; Integer10 . Дано трехзначное число. Вывести вначале его последнюю цифру
; (единицы), а затем — его среднюю цифру (десятки).
;
; Вывод:
; 371 -> 1, 7
extern  printf
section .data
        A       equ     371
        strFormat1      db      "%d -> %d, ",0
        strFormat2      db      "%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     ax, A
        cwd                     ; dx:ax
        mov     bx, 10
        idiv    bx
        push    ax          ; сохраним, понадобится для десятков
        ; остаток - dx, частное - ax
        movsx   rdx, dx
        ; для разнообразия вызовем printf два раза
        mov     rdi, strFormat1
        mov     rsi, A
        ; rdx уже есть
        mov     rax, 0          ; кол-во вещественных
        call    printf
        
        ; теперь десятки
        pop     ax
        cwd
        mov     bx, 10
        idiv    bx
        movsx   rsi, dx

        mov     rdi, strFormat2
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
