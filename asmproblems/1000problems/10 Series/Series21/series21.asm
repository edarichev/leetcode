; Series21 ° . Дано целое число N (> 1) и набор из N вещественных чисел. 
; Проверить, образует ли данный набор возрастающую последовательность. Если
; образует, то вывести True, если нет — вывести False.
;
; Вывод:
; True

extern  printf
section .data
        series1         dq      1,2,3,12,24,25,34,43,44,45,46,55,62,67
        N               equ     14
        strTrue         db      "True",10,0
        strFalse        db      "False",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     rdi, strFalse
        mov     rcx, N
        mov     rbx, -1         ; rbx==предыдущее, заведомо минимальное
        mov     rdx, series1
        
loop_i:
        test    rcx, rcx
        jz      break
        mov     rax, [rdx]
        cmp     rbx, rax
        jg      done
        mov     rbx, rax
        add     rdx, 8
        dec     rcx
        jmp     loop_i
break:
        mov     rdi, strTrue
done:
        mov     rax, 0
        call    printf
        
        leave
        ret
