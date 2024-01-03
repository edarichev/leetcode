; Case11 . Локатор ориентирован на одну из сторон света («С» — север, «З» —
; запад, «Ю» — юг, «В» — восток) и может принимать три цифровые команды поворота: 
; 1 — поворот налево, –1 — поворот направо, 2 — поворот на 180°. 
; Дан символ C — исходная ориентация локатора и целые числа N 1
; и N 2 — две посланные команды. Вывести ориентацию локатора после
; выполнения этих команд.
;
; Вывод:
; Восток (1, 2)
extern  printf
section .data
        C               dq      1       ; пусть 1-Север, 2-Восток, 3-Юг, 4-Запад
        N1              dq      1       ; команда1 1-L, -1-R, 2-180
        N2              dq      2       ; команда2 1-L, -1-R, 2-180
        sNord           db      "Север",0
        sOst            db      "Восток",0
        sSud            db      "Юг",0
        sWest           db      "Запад",0
        names           dq      sNord, sOst, sSud, sWest

        strFormat       db      "%s",10,0
        strError        db      "Не поддерживается",10,0        
section .bss
        D               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rbx, [C]        ; первоначальное направление
        mov     rax, [N1]       ; команда1
        call    rotate
        mov     rax, [N2]       ; команда2
        call    rotate
        ; rbx - направление
        lea     rcx, names
        mov     rsi, [rcx + rbx*8 - 8]
        mov     rax, 0          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
exit:
        leave
        ret

rotate:
        ; rbx - направление
        ; rax - команда
        ; выход: rbx - новое направление
        push    rbp
        mov     rbp, rsp
        cmp     rax, 1
        je      case_left
        cmp     rax, -1
        je      case_right
        cmp     rax, 2
        je      case_180
        jmp     case_default
case_180:
        inc     rbx
        inc     rbx
        mov     rax, rbx
        cdq
        mov     rcx, 4
        idiv    rcx
        mov     rbx, rdx        ; остаток - новое направление
        test    rbx, rbx
        jnz     done
        mov     rbx, 4
        jmp     done
case_left:
        dec     rbx
        cmp     rbx, 0
        jle     to_4
        jmp     done
case_right:
        inc     rbx
        cmp     rbx, 4
        jg      to_1
        jmp     done
case_default:
        mov     rdi, strError
        call    printf
        jmp     done
to_1:
        mov     rbx, 1
        jmp     done
to_4:
        mov     rbx, 4
        jmp     done
done:
        leave
        ret
