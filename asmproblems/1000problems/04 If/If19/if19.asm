; If19 . Даны четыре целых числа, одно из которых отлично от трех других, 
; равных между собой. Определить порядковый номер числа, отличного от остальных.
;
; Вывод:
; 15, 15, 11, 15 -> 2
extern  printf

section .data
        A               dq      15
        B               dq      11
        C               dq      15
        D               dq      15
        strFormat       db      "%d, %d, %d, %d -> %d",10,0
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
        mov     rdx, [D]
        
        ; сначала нужно найти два соседних числа, которые не равны,
        ; и в r8 занести индекс ЛЕВОГО числа пары неравных чисел
        mov     r8, 0
        cmp     rax, rbx
        jne     found2
        mov     r8, 1
        cmp     rbx, rcx
        jne     found2
        mov     r8, 2           ; других вариантов по условию не может быть
found2:
        ; определяем по индексу, какие числа сравнить
        ; это числа по индексу либо r8, либо r8+1
        cmp     r8, 0
        je      checkAC         ; можно проверить A c С|D, допустим, проверим с C
        cmp     r8, 1
        je      checkBD         ; можно проверить B c A|D, допустим, проверим с D
        cmp     r8, 2
        je      checkCA         ; можно проверить C c A|B, допустим, проверим с A
checkAC:
        cmp     rax, rcx
        jne     done            ; да, 0-й, т.е. A отличается от остальных
        mov     r8, 1
        jmp     done
checkBD:
        cmp     rbx, rdx
        jne     done            ; i=1, т.е. B
        mov     r8, 2           ; значит, отличается следующий, т.е. 2==[C]
        jmp     done
checkCA:
        cmp     rcx, rax
        jne     done            ; i==2 -> C
        mov     r8, 3
done:
        ; выводим
        mov     r9, r8
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, [A]
        mov     rdx, [B]
        mov     rcx, [C]
        mov     r8,  [D]
        call    printf
        leave
        ret
