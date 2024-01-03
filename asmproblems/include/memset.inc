_memset:
    ; Fills the buffer with a specified byte
    ; Input:
    ;   rdi - address of buffer
    ;   rsi - byte to fill (lower byte)
    ;   rdx - count of bytes
    ; Returns:
    ;   none
    push    rbp
    mov     rbp, rsp

    mov     rcx, rdx    ; counter
    mov     rax, rsi
.loop:
    mov     [rdi], al
    inc     rdi
    dec     rcx
    jnz     .loop

    xor     rax, rax

    leave
    ret
