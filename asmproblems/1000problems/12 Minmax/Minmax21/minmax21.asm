; Minmax21. Дано целое число N (> 2) и набор из N чисел — значений некоторой
; величины, полученных в N опытах. Найти среднее значение этой величины. 
; При вычислении среднего значения не учитывать минимальное и максимальное из имеющихся в наборе значений.
;
; Вывод:
; 3 (2,3,4,5,2 -> 16/5=3+1/5=>3, без -1 и 8)

; для простоты используем целые
; если предположить, что минимальное и максимальное могут встретиться несколько раз,
; надо ввести для этого 2 счётчика.
; за базу возьмём задачу Minmax20
extern  printf
section .data
        LONG_MIN        equ     0x8000000000000000
        LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
        series1         dq      -1,2,3,4,5,-1,8,2,8,-1
        N               equ     10
        strFormat       db      "%ld",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, 0
        mov     rsi, series1
        mov     rbx, LONG_MAX   ; минимальный
        mov     rdx, 0          ; кол-во минимальных
        mov     r8, LONG_MIN    ; максимальный
        mov     r9, 0           ; кол-во максимальных
        xor     r10, r10        ; полная сумма
loop_i:
        cmp     rcx, N
        je      done
        mov     rax, qword [rsi]
        add     r10, rax        ; сумма в любом случае
        cmp     rax, rbx
        jg      check_greater
        jl      less
        ; тут равно минимальному, значит, увеличть кол-во
        inc     rdx
        jmp     next
less:
        ; строго меньше, начинаем подсчёт заново
        mov     rdx, 1          ; 1 штука
        mov     rbx, rax        ; новый минимум
        jmp     next
check_greater:
        ; тут > минимума, если мы тут, то только из ветки jg      check_greater
        cmp     rax, r8
        jg      greater
        jl      next            ; вряд ли возможно, но поставлю
        ; здесь только равнество
        inc     r9
        jmp     next
greater:
        ; новый максимум, заново
        mov     r9, 1
        mov     r8, rax
        jmp     next
next:
        add     rsi, 8
        inc     rcx
        jmp     loop_i
done:
        ; вычтем сумму минимальных
        imul    rbx, rdx        ; Nmin*Min
        sub     r10, rbx
        
        ; вычтем сумму максимальных
        imul    r8, r9          ; Nmax*Max
        sub     r10, r8
        
        ; вычтем из общего кол-ва общее число макс/мин элементов
        mov     rax, N
        sub     rax, rdx
        sub     rax, r9
        
        mov     rbx, rax        ; теперь это делитель
        mov     rax, r10
        cmp     rax, 0
        je      write
        cdq
        idiv    rbx
write:
        mov     rsi, rax
        xor     rax, rax
        mov     rdi, strFormat
        call    printf
        leave
        ret
