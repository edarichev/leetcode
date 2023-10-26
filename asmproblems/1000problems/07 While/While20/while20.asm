; While20 . Дано целое число N (> 0). С помощью операций деления нацело и взятия 
; остатка от деления определить, имеется ли в записи числа N цифра «2».
; Если имеется, то вывести True, если нет — вывести False.
;
; Вывод:
; True (N = 12345)

extern  printf
section .data
        N               equ     11345
        strTrue         db      "True",10,0
        strFalse        db      "False",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rdi, strFalse   ; можно сразу поставить False, чтобы меньше прыгать
        mov     rax, N
        mov     rbx, 10         ; делитель
        xor     rcx, rcx
loop_i:
        test    rax, rax
        jz      done
        cdq
        div     rbx
        cmp     rdx, 2
        je      labelTrue
        jmp     loop_i
labelTrue:
        mov     rdi, strTrue
        jmp     done
done:
        mov     rax, 0
        call    printf
        leave
        ret
