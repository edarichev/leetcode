; Series10 . Дано целое число N и набор из N целых чисел. Если в наборе имеются 
; положительные числа, то вывести True; в противном случае вывести
; False.
;
; Вывод:
; False (при всех < 0)

extern  printf
section .data
        series1         dq      -1,-2,-3,-4,-5,-6,-7,-8,-9,-10
        N               equ     10
        strTrue         db      "True",10,0
        strFalse        db      "False",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, N
        mov     rdx, series1
        mov     rdi, strFalse
loop_i:
        test    rcx, rcx
        jz      done
        mov     rax, [rdx]
        shr     rax, 63
        test    rax, rax        ; проверить старший бит, ==1 - отрицательное
        jz      setTrue
        dec     rcx
        add     rdx, 8
        jmp     loop_i
setTrue:
        mov     rdi, strTrue
done:
        mov     rax, 0
        call    printf
        
        leave
        ret
