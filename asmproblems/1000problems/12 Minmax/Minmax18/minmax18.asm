; Minmax18. Дано целое число N и набор из N целых чисел. Найти количество
; элементов, содержащихся между первым и последним максимальным элементом. 
; Если в наборе имеется единственный максимальный элемент, то вывести 0.
;
; Вывод:
; 3

extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      1,2,3,4,5,-7,-8,-9,-5,-1
        N               equ     10
        Min             dq      LONG_MAX
        Max             dq      LONG_MIN
        strFormat       db      "%ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     rbx, LONG_MIN
        mov     rdx, 0                  ; тут левый индекс
        mov     r8, 0                   ; второй индекс, правый
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        cmp     rax, rbx
        jl      next
        jg      greater                 ; если >=, то сдвигаем оба индекса
        mov     r8, rcx                 ; == -> только сдвинуть правый
        jmp     next
greater:
        mov     r8, rcx                 ; сдвинуть индекс #2
        mov     rdx, rcx                ; сдвинуть левый индекс
        mov     rbx, rax                ; обновить значение
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        xor     rsi, rsi                ; <= 0; сделаем так на случай, если элемент один
        cmp     r8, rdx                 ; один элемент, т.к. rdx==r8== 1 индекс
        je      write
        mov     rsi, r8
        sub     rsi, rdx
        dec     rsi                     ; т.к. "между", т.е. не включая границы
write:
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
