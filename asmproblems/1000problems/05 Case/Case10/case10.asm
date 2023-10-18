; Case10 . Робот может перемещаться в четырех направлениях («С» — север,
; «З» — запад, «Ю» — юг, «В» — восток) и принимать три цифровые команды: 
; 0 — продолжать движение, 1 — поворот налево, –1 — поворот направо. 
; Дан символ C — исходное направление робота и целое число N —
; посланная ему команда. Вывести направление робота после выполнения
; полученной команды.
;
; Вывод:
; Восток (при 1, -1)
extern  printf
section .data
        C               dq      1       ; пусть 1-Север, 2-Восток, 3-Юг, 4-Запад
        N               dq      -1       ; команда 0, 1, -1
        sNord           db      "Север",0
        sOst            db      "Восток",0
        sSud            db      "Юг",0
        sWest           db      "Запад",0
        names           dq      sNord, sOst, sSud, sWest

        strFormat       db      "%s",10,0
        strError        db      "Не поддерживается",10,0
        ; адреса меток для более эффективного switch/case
        labels          dq      case_0,case_left,case_right,
                        dq      case_default
        
section .bss
        D               resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rbx, [C]        ; первоначальное направление
        mov     rax, [N]        ; команда
        cmp     rax, 1
        je      case_left
        cmp     rax, -1
        je      case_right
        cmp     rax, 0
        je      case_0
        jmp     case_default
case_0:
        ; направление сохраняется
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
        jmp     exit
to_1:
        mov     rbx, 1
        jmp     done
to_4:
        mov     rbx, 4
        jmp     done
done:
        ; rbx - направление
        lea     rcx, names
        mov     rsi, [rcx + rbx*8 - 8]
        mov     rax, 0          ; кол-во вещественных чисел
        mov     rdi, strFormat
        call    printf
exit:
        leave
        ret
