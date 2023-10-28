; While4 ° . Дано целое число N (> 0). Если оно является степенью числа 3, 
; то вывести True, если не является — вывести False.
;
; Вывод:
; True (27, 9, 3 и т.п.)

extern  printf
section .data
        N               equ     3
        strTrue         db      "True",10,0
        strFalse        db      "False",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rbx, N
        mov     rdx, 1
loop_i:
        imul    rdx, 3
        mov     rax, rbx
        sub     rax, rdx
        jz      r_true
        js      r_false         ; SF=1, результат < 0, не делится
        jmp     loop_i
r_false:
        xor     rax, rax
        jmp     result
r_true:
        mov     rax, 1
result:
        test    rax, rax
        jz      set_false
        mov     rdi, strTrue
        jmp     done
set_false:
        mov     rdi, strFalse
done:
        mov     rax, 0        
        call    printf
        leave
        ret
