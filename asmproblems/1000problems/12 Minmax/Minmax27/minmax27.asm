; Minmax27. Дано целое число N и набор из N целых чисел, содержащий только
; нули и единицы. Найти номер элемента, с которого начинается самая
; длинная последовательность одинаковых чисел, и количество элементов в
; этой последовательности. Если таких последовательностей несколько, то
; вывести номер первой из них.
;
; Вывод:
; №=1, C=4

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      0,1,1,1,1,0, 0,0,1,1,0, 1,0,0,0,0, 0
        N               equ     12
        strFormat       db      "№=%ld, C=%ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     rdi, 1          ; предыдущее значение, пусть 0
        mov     rbx, 0          ; макс. кол-во
        xor     rdx, rdx        ; сюда будем складывать временно, в начале 0
        mov     r8, 0           ; номер элемента, с которого началась искомая последовательность
        mov     r9, 0           ; номер элемента, с которого началась текущая последовательность
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, rdi
        jne     odd             ; если != предыдущему, то это новая последовательность
        inc     rdx
        jmp     next
odd:
        cmp     rdx, rbx        ; заменить, если последовательность длиннее
        jle     clear_counter
        mov     rbx, rdx
        mov     r8, r9
clear_counter:
        mov     r9, rcx
        mov     rdx, 1          ; учитываем текущий элемент
next:
        mov     rdi, rax
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        mov     rsi, r8
        mov     rdx, rbx
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
