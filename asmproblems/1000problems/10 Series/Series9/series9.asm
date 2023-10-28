; Series9 . Дано целое число N и набор из N целых чисел. Вывести в том же
; порядке номера всех нечетных чисел из данного набора и количество K таких
; чисел.
;
; Вывод:
;     0    2    4    6    8        (отсчёт с 0)
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
        
        mov     rcx, 0
        mov     rdx, series1
        xor     rbx, rbx        ; кол-во, K
        and     rsp, 0xfffffffffffffff0
loop_i:
        cmp     rcx, N
        je      done
        mov     rsi, [rdx]
        test    rsi, 1
        jz      next            ; чётное
        
        inc     rbx             ; число нечётных+1
        
        push    rcx
        push    rdx
        push    rbx
        sub     rsp, 8          ; выравнивание стека, -8
        
        mov     rax, 0
        mov     rdi, strNumFmt
        mov     rsi, rcx
        call    printf

        add     rsp, 8
        pop     rbx
        pop     rdx
        pop     rcx
next:        
        inc     rcx
        add     rdx, 8
        jmp     loop_i
done:
        mov     rax, 0
        mov     rdi, strFormat
        mov     rsi, rbx
        call    printf
        
        leave
        ret
