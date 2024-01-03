; Series19 ° . Дано целое число N (> 1) и набор из N целых чисел. 
; Вывести те элементы в наборе, которые меньше своего левого соседа, 
; и количество K таких элементов.
;
; Вывод:
; 2 4 3 5 2
; C=5

extern  printf
section .data
        series1         dq      1,2,3,2,4,5,4,3,4,5,6,5,2,7
        N               equ     14
        strFormat       db      "%d ",0
        strCount        db      10,"C=%d",10,0
section .bss
        prev            resq    1       ; пред. число
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        xor     rdx, rdx                ; кол-во
        mov     rcx, N
        mov     rsi, series1
        mov     qword [prev], 0         ; сюда поставим заведомо недопустимое число как флаг
loop_i:
        test    rcx, rcx
        jz      done
        mov     rbx, [prev]
        mov     rdi, qword [rsi]
        mov     qword [prev], rdi
        cmp     rdi, rbx
        jnl     next
        ; число меньше предыдущего, выводим
        inc     rdx
        push    rcx
        push    rsi
        push    rdx
        sub     rsp, 8                  ; выравнивание
        
        mov     rax, 0
        mov     rsi, rdi
        mov     rdi, strFormat
        call    printf
        
        add     rsp, 8
        pop     rdx
        pop     rsi
        pop     rcx
        
next:
        dec     rcx
        add     rsi, 8
        jmp     loop_i
done:
        mov     rax, 0
        mov     rdi, strCount
        mov     rsi, rdx
        call    printf
        
        leave
        ret
