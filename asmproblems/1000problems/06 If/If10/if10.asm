; If10 . Даны две переменные целого типа: A и B . Если их значения не равны, то
; присвоить каждой переменной сумму этих значений, а если равны, то присвоить 
; переменным нулевые значения. Вывести новые значения переменных A и B .
;
; Вывод:
; 25, 20 -> 45, 45
extern  printf

section .data
        A               dq      25
        B               dq      25
        strFormat       db      "%d, %d -> %d, %d",10,0
section .bss
        A1              resq    1
        B1              resq    1
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rax, [A]
        mov     rbx, [B]
        cmp     rax, rbx
        je      equals
        add     rax, rbx
        mov     [A1], rax
        mov     [B1], rax
        jmp     done
equals:
        xor     rax, rax
        mov     [A1], rax       ; можно так
        mov     qword [B1], 0   ; или так
done:
        ; вывод
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, [A]
        mov     rdx, [B]
        mov     rcx, [A1]
        mov     r8, [B1]
        call    printf
        leave
        ret
