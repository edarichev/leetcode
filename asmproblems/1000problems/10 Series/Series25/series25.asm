; Series25 . Дано целое число N и набор из N целых чисел, содержащий по крайней 
; мере два нуля. Вывести сумму чисел из данного набора, расположенных 
; между первым и последним нулем (если первый и последний нули
; идут подряд, то вывести 0).
;
; Вывод:
; Sum=15

extern  printf
section .data
        series1         dq      1,2,3,0,1,2,0,3,4,5,0,34
        cend            dq      $
        N               equ     12
        strFormat       db      "Sum=%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, N
        xor     rdx, rdx
        ; сначала идём сзади к началу
        mov     rdi, [cend]
        sub     rdi, 8
loop_i:
        test    rcx, rcx
        jz      break_i
        cmp     qword [rdi], 0
        je      break_i         ; первый ноль сзади
next:
        sub     rdi, 8
        dec     rcx
        jmp     loop_i
break_i:
        test    rcx, rcx
        jz      done            ; нулей нет
        mov     rax, rcx        ; сохраним последний 0 в rax
        ; ищем второй 0, теперь идём с 0
        xor     rcx, rcx
        mov     rdi, series1
loop_j:
        cmp     rcx, N
        je      break_j
        cmp     qword [rdi], 0
        je      break_j
        add     rdi, 8
        inc     rcx
        jmp     loop_j
break_j:
        cmp     rcx, N
        je      done            ; нет нулей
        ; теперь надо пройти от rcx до rax и всё сложить
loop_k:
        cmp     rcx, rax
        je      done
        add     rdx, qword [rdi]
        add     rdi, 8
        inc     rcx
        jmp     loop_k
done:
        mov     rdi, strFormat
        mov     rsi, rdx
        call    printf
        leave
        ret
