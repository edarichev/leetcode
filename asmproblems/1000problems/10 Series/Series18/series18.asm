; Series18 . Дано целое число N и набор из N целых чисел, упорядоченный по
; возрастанию. Данный набор может содержать одинаковые элементы. 
; Вывести в том же порядке все различные элементы данного набора.
;
; Вывод:
; 1 2 3 4 5 6 7 8

extern  printf
section .data
        series1         dq      1,1,2,2,3,3,3,4,4,5,6,7,7,8
        N               equ     14
        strFormat       db      "%d ",0
        NL              db      10,0
section .bss
        prev            resq    1       ; пред. число
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, N
        mov     rsi, series1
        mov     qword [prev], 0         ; сюда поставим заведомо недопустимое число как флаг
loop_i:
        test    rcx, rcx
        jz      done
        mov     rax, [rsi]
        cmp     rax, qword [prev]
        je      next                    ; предыдущее равно этому
        mov     qword [prev], rax       ; запомнить текущее
        ; выводим новое число
        push    rcx
        push    rsi
        
        mov     rsi, rax
        mov     rax, 0
        mov     rdi, strFormat
        call    printf
        
        pop     rsi
        pop     rcx
next:
        dec     rcx
        add     rsi, 8
        jmp     loop_i
done:
        mov     rax, 0
        mov     rdi, NL
        call    printf
        
        leave
        ret
