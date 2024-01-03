; Series40 . Дано целое число K , а также K наборов ненулевых целых чисел. 
; Каждый набор содержит не менее трех элементов, признаком его завершения34
; является число 0. Для каждого набора выполнить следующее действие: 
; если набор является пилообразным (см. задание Series23), то вывести 
; количество его элементов; в противном случае вывести номер первого элемента, который не является зубцом.
;
; Вывод:
; S0 -> 8
; S1 -> 3
; S2 -> 4

extern  printf
section .data
        series1         dq      61,52,63,32,45,16,27,0  ; пила
        series2         dq      6,7,8,9,10,0
        series3         dq      51,11,32,13,0           ; пила
        K               equ     3
        strFormat       db      "S%d -> %d",10,0
        arr             dq      series1, series2, series3
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        xor     rcx, rcx
        mov     rdi, arr
loop_row:
        cmp     rcx, K
        je      break_loop_row
        mov     rbx, qword [rdi]
        ; по условию как минимум 3 элемента есть
        mov     rsi, 3
        mov     r8, [rbx]
        add     rbx, 8
        mov     r9, [rbx]
        add     rbx, 8
        cmp     r8, r9
        je      next            ; не пилообразный, a[0]==a[1]
        mov     rax, 0          ; в rax переключатель: если 0, то это спад, значит, следующий ожидаем, что a[n-1] < a[n]
        jl      loop_col
        mov     al, 0xFF        ; будем делать XOR, тогда ветвлений намного меньше
        loop_col:
                mov     r8, r9
                mov     r9, qword [rbx]
                cmp     r9, 0
                je      break_loop_col  ; конец серии
                cmp     r8, r9
                je      break_loop_col
                ; схема та же: если следующий < предыдущего, то это спад, флаг == 0xFF
                mov     rdx, 0
                jl      check_pair
                mov     dl, 0xFF
                check_pair:
                        ; если набор пилообразный, то предыдущий флажок в al должен быть противоположен
                        ; текущему флажку в dl
                        ; поэтому их XOR должен дать 0xFF, а если же в AL был спад (0x00), и сейчас спад (0x00),
                        ; то их XOR даст 0, то же верно и для 0xFF ^ 0xFF
                        xor     dl, al
                        jz      break_loop_col
                        not     al      ; меняем флажок на противоположный
                add     rbx, 8
                inc     rsi     ; номер элемента++
                jmp     loop_col
        break_loop_col:
                test    r9, r9  ; если мы дошли до конечного 0, то набор удовлетворяет условию, в r9 д.б. конечный элемент == 0
                jnz     next
                dec     rsi     ; в противном случае уменьшить на 1, т.к. мы на последнем 0, а это на 1 больше искомого кол-ва
next:
        and     rsp, 0xfffffffffffffff0
        push    rcx
        push    rdi
        
        mov     rdi, strFormat
        mov     rdx, rsi
        mov     rsi, rcx
        call    printf

        pop     rdi
        pop     rcx
        inc     rcx
        add     rdi, 8
        jmp     loop_row
break_loop_row:
        leave
        ret
