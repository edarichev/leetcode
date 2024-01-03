; For40 . Даны целые числа A и B ( A < B ). Вывести все целые числа от A до B
; включительно; при этом число A должно выводиться 1 раз, число A + 1
; должно выводиться 2 раза и т. д.
;
; Вывод:
; 4 
; 5 5 
; 6 6 6 
; 7 7 7 7 
; 8 8 8 8 8 

extern  printf
section .data
        A               equ     4
        B               equ     8
        strFormat       db      "%d ",0
        NL              db      10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rcx, A          ; внешний счётчик, текущее число
        mov     rdx, 1          ; счётчик, сколько раз вывели число, не более указанного в задании числа раз
loop_current_number:
        cmp     rcx, B
        jg      done
        mov     rbx, 1
        loop_print:
                cmp     rbx, rdx
                jg      break_loop_print
                ; сохраняем, выравнивание д.б. == 16
                push    rcx     ; 8
                push    rdx     ; ещё 8, поэтому исправлять RSP не нужно
                push    rbx     ; ещё 8, поэтому исправим:
                sub     rsp, 8
                
                mov     rdi, strFormat
                mov     rax, 0
                mov     rsi, rcx
                call    printf
                
                add     rsp, 8
                pop     rbx
                pop     rdx
                pop     rcx
                inc     rbx
                
                jmp     loop_print
        break_loop_print:
        ; по соглашениям, конечно, RBX восстанавливает вызываемая функция,
        ; и можно было счётчик засунуть в RBX, но где гарантия?
        push    rcx             ; 8 байт
        push    rdx             ; +8=16
        
        mov     rax, 0
        mov     rdi, NL         ; перенос на новую строку для красоты
        call    printf
        
        pop     rdx             ; 8
        pop     rcx             ; +8 байт=16, OK

        inc     rcx
        inc     rdx
        jmp     loop_current_number
done:
        leave
        ret
