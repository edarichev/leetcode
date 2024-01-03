; Array39. Дан массив размера N. Найти количество его промежутков монотонности 
; (то есть участков, на которых его элементы возрастают или убывают).
;
; Вывод:
; 0+0=0     (arr)
; 1+2=3     (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      -3, 2, -5, 1, -20, 4, -99, 160, -321, 20
        arr1            dq      1,2,3,-4,5,6,7,-8,-9,10
        strFormat       db      "%ld",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; монотонно - значит не менее двух подряд в одну сторону
        ; проще всего пройтись 2 раза по массиву, чем городить кучу ветвлений
        ; объединим два предыдущих решения
        mov     r8, arr1                 ; это запомним, чтоб 2 раза не писать
        ; сначала убывание
        mov     rcx, 0                  ; нумеруем с 0
        mov     rsi, r8
        mov     rax, qword [rsi]        ; левый
        mov     rdx, 0                  ; признак: 0 - условие монотонности не выполняется, не 0 - выполняется, храним число точек в последовательности
        mov     rdi, 0                  ; ответ
loop_i:
        inc     rcx
        cmp     rcx, N
        jge     break_i
        add     rsi, 8
        mov     rbx, qword [rsi]
        cmp     rax, rbx
        jle     err
        inc     rdx                     ; признак: монотонность
        jmp     next
err:
        cmp     rdx, 2                  ; предыдущий участок рос? (не менее 2 точек)
        jl      set_zero
        inc     rdi                     ; +1 число участков
set_zero:
        mov     rdx, 0
next:
        jmp     loop_i
break_i:

        ; теперь возрастание
        
        mov     rcx, 0                  ; нумеруем с 0
        mov     rsi, r8
        mov     rax, qword [rsi]        ; левый
        mov     rdx, 0                  ; признак: 0 - условие монотонности не выполняется, не 0 - выполняется, храним число точек в последовательности
loop_j:
        inc     rcx
        cmp     rcx, N
        jge     break_j
        add     rsi, 8
        mov     rbx, qword [rsi]
        cmp     rbx, rax
        jle     err2
        inc     rdx                     ; признак: монотонность
        jmp     next2
err2:
        cmp     rdx, 2                  ; предыдущий участок рос? (не менее 2 точек)
        jl      set_zero2
        inc     rdi                     ; +1 число участков
set_zero2:
        mov     rdx, 0
next2:
        jmp     loop_j
break_j:
        mov     rsi, rdi
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
