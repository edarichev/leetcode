; Array40. Дано число R и массив A размера N. Найти элемент массива, который
; наиболее близок к числу R (то есть такой элемент A K , для которого величина |A K – R| является минимальной).
;
; Вывод:
; 20     (arr)
; 10     (arr1)

%include "../../utils.inc"

extern  printf
section .data
        R               equ     15
        N               equ     10
        arr             dq      -3, 2, -5, 1, -20, 4, -99, 160, -321, 20
        arr1            dq      1,2,3,-4,5,6,7,-8,-9,10
        strFormat       db      "%ld",10,0
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, N
        mov     rsi, arr1
        mov     rdx, LONG_MAX   ; 
        mov     rdi, 0          ; ответ
loop_i:
        test    rcx, rcx
        jz      break_i
        mov     rax, qword [rsi]
        mov     r8, rax
        
        sub     rax, R          ; Ak-R
        mov     rbx, rax
        neg     rax
        cmovl   rax, rbx        ; |Ak-R|
        
        cmp     rax, rdx        ; если разница меньше, сохраним значение
        jg      next
        mov     rdx, rax
        mov     rdi, r8
next:
        dec     rcx
        add     rsi, 8
        jmp     loop_i
break_i:
        mov     rsi, rdi
        mov     rdi, strFormat
        call    printf
        
        leave
        ret
