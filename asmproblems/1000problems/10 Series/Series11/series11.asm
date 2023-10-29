; Series11 . Даны целые числа K , N и набор из N целых чисел. Если в наборе
; имеются числа, меньшие K , то вывести True; в противном случае вывести
; False.
;
; Вывод:
; False (при < 1)

extern  printf
section .data
        series1         dq      1,2,3,4,5,6,7,8,9,10
        N               equ     10
        K               equ     1
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
        cmp     rax, K
        jl      setTrue
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
