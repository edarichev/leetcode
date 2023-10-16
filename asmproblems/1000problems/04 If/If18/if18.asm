; If18 . Даны три целых числа, одно из которых отлично от двух других, равных
; между собой. Определить порядковый номер числа, отличного от остальных.
;
; Вывод:
; 15, 15, 11 -> 2
extern  printf

section .data
        A               dq      11
        B               dq      15
        C               dq      11
        strFormat       db      "%d, %d, %d -> %d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; здесь проще сравнить попарно и методом исключения определить индекс
        mov     rax, [A]
        mov     rbx, [B]
        mov     rcx, [C]
        
        ; rdx - здесь индекс
        mov     rdx, 2          ; если a==b, то индекс == 2
        cmp     rax, rbx
        je      done
        mov     rdx, 1          ; если a==c -> i==1
        cmp     rax, rcx
        je      done
        mov     rdx, 0          ; i==0, по условию других вариантов нет
done:
        mov     r8, rdx
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, [A]
        mov     rdx, [B]
        mov     rcx, [C]
        call    printf
        leave
        ret
