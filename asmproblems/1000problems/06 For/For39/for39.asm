; For39 . Даны целые положительные числа A и B ( A < B ). Вывести все целые
; числа от A до B включительно; при этом каждое число должно выводиться
; столько раз, каково его значение (например, число 3 выводится 3 раза).
;
; Вывод:
; 1 
; 2 2 
; 3 3 3 
; 4 4 4 4 
; 5 5 5 5 5 

extern  printf
section .data
        A               equ     7
        B               equ     9
        strFormat       db      "%d ",0
        NL              db      10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        ; нужно 2 счётчика
        mov     rcx, A          ; внешний счётчик, текущее число
loop_current_number:
        cmp     rcx, B
        jg      done
        mov     rdx, 1          ; внутренний счётчик, сколько раз вывели число, не более rcx раз
        loop_print:
                cmp     rdx, rcx
                jg      break_loop_print
                ; сохраняем, выравнивание д.б. == 16
                push    rcx     ; 8
                push    rdx     ; ещё 8, поэтому исправлять RSP не нужно
                
                mov     rdi, strFormat
                mov     rax, 0
                mov     rsi, rcx
                call    printf
                
                pop     rdx
                pop     rcx
                inc     rdx
                
                jmp     loop_print
        break_loop_print:
        ; по соглашениям, конечно, RBX восстанавливает вызываемая функция,
        ; и можно было счётчик засунуть в RBX, но где гарантия?
        push    rcx             ; 8 байт
        sub     rsp, 8          ; и выравнивание, ещё 8
        
        mov     rax, 0
        mov     rdi, NL         ; перенос на новую строку для красоты
        call    printf
        
        add     rsp, 8          ; исправим RSP
        pop     rcx             ; т.к. до RCX ещё 8 байт

        inc     rcx
        jmp     loop_current_number
done:
        leave
        ret
