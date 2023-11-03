; Series37 . Дано целое число K , а также K наборов ненулевых целых чисел. 
; Каждый набор содержит не менее двух элементов, признаком его завершения
; является число 0. Найти количество наборов, элементы которых возрастают или убывают.
;
; Вывод:
; 2

extern  printf
section .data
        series1         dq      1,61,52,43,32,25,16,7,0
        series2         dq      6,7,8,9,10,0
        series3         dq      11,12,13,0
        K               equ     3
        strFormat       db      "%d",10,0
        arr             dq      series1, series2, series3
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        xor     rcx, rcx
        mov     rdi, arr
        xor     rsi, rsi          ; rsi==кол-во наборов
loop_row:
        cmp     rcx, K
        je      break_loop_row
        mov     rbx, qword [rdi]
        xor     rdx, rdx
        mov     r8, -1          ; поставим наименьшее число, в данном случаем можно -1
        mov     r9, 0           ; 0 - неудача, 1 - возрастающий
        mov     r10, 0          ; 0 - неудача, 1 - убывающий
        xor     rdx, rdx
        loop_col:
                mov     rax, qword [rbx]
                cmp     rax, 0          ; пока != 0
                je      break_loop_col
                cmp     rdx, 0
                je      next_col        ; первый пропустить
                cmp     r8, rax
                jle     ok_asc
                or      r10, 1
                jmp     next_col
        ok_asc:
                or      r9, 1
        next_col:
                mov     r8, rax
                add     rbx, 8
                inc     rdx
                jmp     loop_col
        break_loop_col:
        cmp     r9, r10 ; д.б. в одном наборе 0, а в другом 1
        je      next    ; если оба условия выполнены, то набор смешанный
        inc     rsi     ; этот набор возрастает или убывает, +1
next:
        inc     rcx
        add     rdi, 8
        jmp     loop_row
break_loop_row:
        mov     rdi, strFormat
        call    printf
        leave
        ret
