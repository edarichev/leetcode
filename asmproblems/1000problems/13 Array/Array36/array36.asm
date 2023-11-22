; Array36. Дан массив размера N. Найти максимальный из его элементов, не 
; являющихся ни локальным минимумом, ни локальным максимумом 
; (определения локального минимума и локального максимума даны в заданиях Array32 и Array33). 
; Если таких элементов в массиве нет, то вывести 0.
;
; Вывод:
; 0     (arr)
; 9     (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      -3, 2, -5, 1, -20, 4, -99, 160, -321, 20
        arr1            dq      1,-2,3,-4,5,6,7,8,9,10
        strFormat       db      "%ld",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; массив нумеруем с 1 по условию
        ; первый и последний элементы не учитываем
        mov     rcx, 2
        mov     rsi, arr1
        mov     rax, qword [rsi]        ; левый
        add     rsi, 8
        mov     rbx, qword [rsi]        ; центр
        mov     rdi, LONG_MIN           ; макс. из элементов
loop_i:
        inc     rcx
        cmp     rcx, N
        jg      break_i
        add     rsi, 8
        mov     rdx, qword [rsi]        ; правый
        ; проверим локальный максимум:
        cmp     rbx, rax
        jl      check_min
        cmp     rax, rdx
        jg      next                    ; это точно максимум, не учитываем его
        jmp     check_if_greater
check_min: ; здесь мы, только если rbx<rax
        ; проверим, не минимум ли
        cmp     rbx, rdx
        jl      next                    ; это минимум
check_if_greater:
        ; если больше, то заменим
        cmp     rbx, rdi
        jle     next
        mov     rdi, rbx
        jmp     next
next:
        mov     rax, rbx                ; меняем 2 предыдущих
        mov     rbx, rdx
        jmp     loop_i
break_i:
        mov     rax, LONG_MIN
        xor     rax, rdi
        jnz     write
        xor     rdi, rdi
write:
        mov     rsi, rdi
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
