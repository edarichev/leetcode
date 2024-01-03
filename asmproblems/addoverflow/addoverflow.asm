; сложение с переполнением
; сложим 16-битные без знака
; результат поместим в [bl:ah:al]
; 1011011010101010+1000011111001011=10011111001110101=81525
; 1111111111111111+1111111111111111=11111111111111110=131070
extern  printf
section .data
        hi1     db      11111111b
        lo1     db      11111111b
        hi2     db      11111111b
        lo2     db      11111111b
        fmt     db      "%d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        xor     rax, rax
        xor     rbx, rbx
        mov     al, [lo1]
        clc                     ; clear carry flag
        add     al, [lo2]       ; 1'01110101
        jnc     nocf
        mov     bh, 1           ; перенос есть, запомним
nocf:   mov     ah, [hi1]
        add     ah, [hi2]
        jnc     nocf2
        mov     cl, 1           ; перенос от hi1+hi2
nocf2:  add     ah, bh          ; перенос от lo1+lo2
        jnc     nocf3
        mov     bl, 1
nocf3:  
        add     bl, cl
        
        ; для вывода соберём воедино:
        xor     rcx, rcx
        mov     cl, bl
        shl     rcx, 16
        mov     cx, ax
        
        xor     rax, rax
        mov     rdi, fmt
        mov     rsi, rcx
        call    printf
        leave
        ret
