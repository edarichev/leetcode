; Array45. Дан массив размера N. Найти номера двух ближайших элементов из
; этого массива (то есть элементов с наименьшим модулем разности) и 
; вывести эти номера в порядке возрастания.
;
; Вывод:
; 1,2      (arr)
; 7,8      (arr1)

%include "../../utils.inc"

extern  printf
section .data
        N               equ     10
        arr             dq      1,2,11,3,4,2,6,7,8,9
        arr1            dq      9,5,7,11,5,13,4,3,12,10
        strFormat       db      "%ld, %ld",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; поскольку массив может быть не упорядочен, то будет вложенный цикл
        mov     rcx, 1          ; отсчёт с 1 по условию
        mov     rsi, arr1
        mov     rax, qword [rsi]
        mov     r8, -1          ; № первого
        mov     r9, -1          ; № второго
        mov     r10, LONG_MAX   ; для текущего значения разности
loop_i:
        inc     rcx
        cmp     rcx, N
        jg      break_i
        add     rsi, 8
        mov     rbx, qword [rsi]
        
        mov     rdx, rax
        sub     rdx, rbx
        
        mov     rdi, rdx
        neg     rdx
        cmovl   rdx, rdi        ; |rax-rbx|
        
        cmp     rdx, r10
        jge     next
        mov     r10, rdx
        mov     r8, rcx
        dec     r8              ; т.к. он уже увеличен
        mov     r9, rcx         ; а это - текущий номер
next:
        mov     rax, rbx        ; сдвиг, теперь это предыдущий
        jmp     loop_i
break_i:
        mov     rdi, strFormat
        mov     rsi, r8
        mov     rdx, r9
        call    printf
        
        leave
        ret
