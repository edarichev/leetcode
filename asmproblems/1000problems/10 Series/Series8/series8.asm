; Series8 . Дано целое число N и набор из N целых чисел. Вывести в том же
; порядке все четные числа из данного набора и количество K таких чисел.
;
; Вывод:
;      2    4    6    8   10
; K=5

extern  printf
section .data
        series1         dq      1,2,3,4,5,6,7,8,9,10
        N               equ     10
        strNumFmt       db      "%5d",0
        strFormat       db      10,"K=%d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, N
        mov     rdx, series1
        xor     rbx, rbx        ; кол-во, K
        and     rsp, 0xfffffffffffffff0
loop_i:
        test    rcx, rcx
        jz      done
        mov     rsi, [rdx]
        test    rsi, 1
        jnz     next            ; нечётное
        
        inc     rbx             ; число чётных+1
        
        push    rcx
        push    rdx
        push    rbx
        sub     rsp, 8          ; выравнивание стека, -8
        
        mov     rax, 0
        mov     rdi, strNumFmt
        ; rsi - число
        call    printf

        add     rsp, 8
        pop     rbx
        pop     rdx
        pop     rcx
next:        
        dec     rcx
        add     rdx, 8
        jmp     loop_i
done:
        mov     rax, 0
        mov     rdi, strFormat
        mov     rsi, rbx
        call    printf
        
        leave
        ret
