
LONG_MAX        equ     0x7FFFFFFFFFFFFFFF
LONG_MIN        equ     -9223372036854775808

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Вывод одномерного массива типа Int64
PrintInt64Array:
        ; Вход: rdi - адрес массива
        ;       rsi - число элементов
section .data
        .formatStart    db      "[",0
        .format1        db      "%d, ",0     ; в середине
        .format2        db      "%d",0       ; последний элемент
        .formatEnd      db      "]",10,0
section .text
        push    rbp
        mov     rbp, rsp
        
        mov     rdx, rdi
        mov     rcx, rsi

        push    rcx
        push    rdx
        xor     rax, rax
        mov     rdi, .formatStart
        call    printf
        pop     rdx
        pop     rcx
.loop_i:
        test    rcx, rcx
        jz      .exit
        mov     rdi, .format1
        cmp     rcx, 1
        jg      .write
        mov     rdi, .format2
.write:
        xor     rax, rax
        push    rcx
        push    rdx
        mov     rsi, qword [rdx]
        call    printf
        pop     rdx
        pop     rcx
        dec     rcx
        add     rdx, 8
        jmp     .loop_i
.exit:
        xor     rax, rax
        mov     rdi, .formatEnd
        call    printf
        
        leave
        ret
