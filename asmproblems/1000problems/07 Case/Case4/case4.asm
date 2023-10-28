; Case4 ° . Дан номер месяца — целое число в диапазоне 1–12 (1 — январь, 2 — февраль и т. д.). 
; Определить количество дней в этом месяце для невисокосного года.
;
; Вывод:
; 6 - 30
extern  printf
section .data
        K               dq      6
        strFormat       db      "%d - %d",10,0
        ; адреса меток для более эффективного switch/case
        labels          dq      case_1,case_2,case_3,case_4,case_5,case_6
                        dq      case_7,case_8,case_9,case_10,case_11,case_12,
                        dq      case_default
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; задача на switch/case, хотя быстрее с массивом
        mov     rax, [K]
        cmp     rax, 1
        jb      case_default
        cmp     rax, 12
        ja      case_default
        lea     rcx, labels
        jmp     [rcx + rax*8 - 8]
case_1:
        mov     rdx, 31
        jmp     done
case_2:
        mov     rdx, 28
        jmp     done
case_3:
        mov     rdx, 31
        jmp     done
case_4:
        mov     rdx, 30
        jmp     done
case_5:
        mov     rdx, 31
        jmp     done
case_6:
        mov     rdx, 30
        jmp     done
case_7:
        mov     rdx, 31
        jmp     done
case_8:
        mov     rdx, 31
        jmp     done
case_9:
        mov     rdx, 30
        jmp     done
case_10:
        mov     rdx, 31
        jmp     done
case_11:
        mov     rdx, 30
        jmp     done
case_12:
        mov     rdx, 31
        jmp     done
case_default:
        mov     rdx, -1
done:
        mov     rax, 0          ; кол-во вещественных чисел
        mov     rdi, strFormat
        mov     rsi, [K]
        call    printf
        
        leave
        ret
