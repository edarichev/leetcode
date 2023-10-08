_memcpy:
        ; Copy memory
        ; Input:
        ;       rdi - target
        ;       rsi - source
        ;       rdx - n
        ; Returns:
        ;       none
        push    rbp
        mov     rbp, rsp
        xor     rax, rax
.loop:
        mov     al, [rsi]
        mov     [rdi], al
        inc     rdi
        inc     rsi
        dec     rdx
        jnz     .loop
        
        leave
        ret
